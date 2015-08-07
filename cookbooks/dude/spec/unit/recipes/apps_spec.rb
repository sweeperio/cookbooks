#
# Cookbook Name:: dude
# Spec:: ejson
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dude::apps" do
  before do
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("tokens", "github").and_return(
      "id"             => "github",
      "sweeper-deploy" => "12345abcdefghijklmnopqrstuvwxyz"
    )

    expect(Chef::EncryptedDataBagItem).to receive(:load).with("ejson", "keys").and_return(
      "id" => "keys",
      "dude" => {
        "public" => "public_key",
        "private" => "private_key"
      }
    )
  end

  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new do |node|
      node.set["apps"] = %w(dude)
    end

    runner.converge(described_recipe)
  end

  context "with app definition" do
    before do
      expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
        "id"          => "dude",
        "github_repo" => "sweeperio/dude"
      )
    end

    it "creates the ejson keys directory" do
      expect(chef_run).to create_directory("/opt/ejson/keys").with(
        recursive: true,
        owner: "deploy",
        group: "deploy",
        mode: "0660"
      )
    end

    it "creates the source directory" do
      expect(chef_run).to create_directory("/var/code").with(
        owner: "deploy",
        group: "deploy",
        mode: "0770",
        recursive: true
      )
    end

    it "creates a deploy key for the dude repo" do
      expect(chef_run).to add_deploy_key("dude_deploy_key").with(
        path: "/var/code/.ssh",
        credentials: { token: "12345abcdefghijklmnopqrstuvwxyz" },
        repo: "sweeperio/dude",
        owner: "deploy",
        group: "deploy",
        mode: "0640"
      )
    end
  end

  context "when ejson_keys are defined" do
    before do
      expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
        "id"          => "dude",
        "github_repo" => "sweeperio/dude",
        "ejson_keys"  => ["dude"]
      )
    end

    it "sets the ejson file appropriately" do
      expect(chef_run).to create_file("/opt/ejson/keys/public_key").with(
        content: "private_key",
        owner: "deploy",
        group: "deploy",
        mode: "0440"
      )
    end
  end

  context "when ejson_keys are not defined" do
    before do
      expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
        "id"          => "dude",
        "github_repo" => "sweeperio/dude"
      )
    end

    it "converges successfully" do
      expect { chef_run }.to_not raise_error
    end
  end
end
