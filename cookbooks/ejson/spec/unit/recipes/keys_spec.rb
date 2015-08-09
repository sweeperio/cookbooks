#
# Cookbook Name:: ejson
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "ejson::keys" do
  cached(:chef_run) do
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("ejson", "keys").and_return(
      "id" => "keys",
      "dude" => { "public" => "public_key", "private" => "private_key" },
      "dead_app" => { "public" => "dead_key", "private" => "private_key" }
    )

    runner = ChefSpec::ServerRunner.new do |node|
      node.set["ejson"]["keys"] = {
        "add" => %w(dude),
        "remove" => %w(dead_app unknown_key)
      }
    end

    runner.converge(described_recipe)
  end

  it "creates key files for keys in the add array" do
    expect(chef_run).to create_file("/opt/ejson/keys/public_key").with(
      owner: "deploy",
      group: "deploy",
      mode: "0440",
      content: "private_key"
    )
  end

  it "removes keys in the remove array" do
    expect(chef_run).to delete_file("/opt/ejson/keys/dead_key")
  end
end
