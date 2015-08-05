#
# Cookbook Name:: base
# Spec:: apps
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "base::apps" do
  before do
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("apps", "dude").and_return(
      "id" => "dude",
      "ejson_keys" => ["dude"]
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
    runner = ChefSpec::ServerRunner.new(step_into: %w(base_ejson_key)) do |node|
      node.set["apps"] = {
        "dude" => { "target" => "/u/apps/dude" }
      }
    end

    runner.converge(described_recipe)
  end

  it "creates the ejson key" do
    expect(chef_run).to create_file("/opt/ejson/keys/public_key").with(
      content: "private_key",
      mode: 0440,
      owner: "deploy",
      group: "deploy"
    )
  end

  it "creates the target folder" do
    expect(chef_run).to create_directory("/u/apps/dude").with(
      mode: 0775,
      recursive: true,
      owner: "deploy",
      group: "deploy"
    )
  end
end
