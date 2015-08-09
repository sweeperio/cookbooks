#
# Cookbook Name:: dude
# Spec:: apps
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dude::apps" do
  context "when app defines missing ejson key" do
    let(:chef_run) do
      expect(Chef::EncryptedDataBagItem).to receive(:load).with("tokens", "github").and_return(
        "id"             => "github",
        "sweeper-deploy" => "12345abcdefghijklmnopqrstuvwxyz"
      )

      expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
        "id"          => "dude",
        "github_repo" => "sweeperio/dude",
        "ejson_keys"  => %w(dude not_defined)
      )

      runner = ChefSpec::ServerRunner.new do |node|
        node.set["apps"] = %w(dude)
        node.set["ejson"]["keys"]["add"] = %w(dude)
      end
    end

    it "gets all fatal on converge" do
      expect { chef_run.converge(described_recipe) }.to raise_error(SystemExit)
    end
  end

  cached(:chef_run) do
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("tokens", "github").and_return(
      "id"             => "github",
      "sweeper-deploy" => "12345abcdefghijklmnopqrstuvwxyz"
    )

    expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
      "id"          => "dude",
      "github_repo" => "sweeperio/dude",
      "ejson_keys"  => %w(dude)
    )

    runner = ChefSpec::ServerRunner.new do |node|
      node.set["apps"] = %w(dude)
      node.set["ejson"]["keys"]["add"] = %w(dude)
    end

    runner.converge(described_recipe)
  end

  it "creates the ssh directory" do
    expect(chef_run).to create_directory("/home/deploy/.ssh").with(
      owner: "deploy",
      group: "deploy",
      mode: "0700"
    )
  end

  it "creates the ssh wrapper file" do
    expect(chef_run).to create_template("/home/deploy/.ssh/dude_deploy_key.sh").with(
      source: "ssh_wrapper.erb",
      owner: "deploy",
      group: "deploy",
      mode: "0750",
      variables: { key: "/home/deploy/.ssh/dude_deploy_key" }
    )
  end

  it "creates a deploy key for the dude repo" do
    expect(chef_run).to add_deploy_key("dude_deploy_key").with(
      path: "/home/deploy/.ssh",
      credentials: { token: "12345abcdefghijklmnopqrstuvwxyz" },
      repo: "sweeperio/dude",
      owner: "deploy",
      group: "deploy",
      mode: "0600"
    )
  end
end
