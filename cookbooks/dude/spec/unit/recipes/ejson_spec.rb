#
# Cookbook Name:: dude
# Spec:: ejson
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dude::ejson" do
  before do
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

  it "creates the ejson keys directory" do
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
      "id" => "dude"
    )

    expect(chef_run).to create_directory("/opt/ejson/keys").with(
      recursive: true,
      owner: "deploy",
      group: "deploy",
      mode: 660
    )
  end

  it "creates the source directory" do
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
      "id" => "dude"
    )

    expect(chef_run).to create_directory("/code").with(
      owner: "deploy",
      group: "deploy",
      mode: 700
    )
  end

  context "when ejson_keys are defined" do
    before do
      expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
        "id" => "dude",
        "ejson_keys" => ["dude"]
      )
    end

    it "sets the ejson file appropriately" do
      expect(chef_run).to create_file("/opt/ejson/keys/public_key").with(
        content: "private_key",
        owner: "deploy",
        group: "deploy",
        mode: 440
      )
    end
  end

  context "when ejson_keys are not defined" do
    before do
      expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
        "id" => "dude"
      )
    end

    it "converges successfully" do
      expect { chef_run }.to_not raise_error
    end
  end
end
