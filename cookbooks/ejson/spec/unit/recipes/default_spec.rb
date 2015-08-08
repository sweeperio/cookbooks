#
# Cookbook Name:: ejson
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "ejson::default" do
  cached(:chef_run) do
    expect(Chef::EncryptedDataBagItem).to receive(:load).and_return([])

    runner = ChefSpec::ServerRunner.new do |node|
      node.set["ejson"]["owner"] = "ejson_owner"
      node.set["ejson"]["group"] = "ejson_group"
    end

    runner.converge(described_recipe)
  end

  it "creates the ejson keys directory" do
    expect(chef_run).to create_directory("/opt/ejson/keys").with(
      recursive: true,
      owner: "ejson_owner",
      group: "ejson_group",
      mode: "0550"
    )
  end

  it "should include the keys recipe" do
    expect(chef_run).to include_recipe("ejson::keys")
  end
end
