#
# Cookbook Name:: dude
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dude::default" do
  cached(:chef_run) do
    stub_command("grep -q chruby /home/deploy/.bashrc").and_return(true)
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("tokens", "github").and_return([])

    runner = ChefSpec::ServerRunner.new do |node|
      node.set["ejson"]["keys"] = {}
    end

    runner.converge(described_recipe)
  end

  %w(dude::apps).each do |recipe|
    it "should include the #{recipe} recipe" do
      expect(chef_run).to include_recipe(recipe)
    end
  end

  it "should create the upstart init file" do
    expect(chef_run).to create_template("/etc/init/dude.conf").with(
      source: "dude.conf.erb",
      owner: "root",
      group: "root",
      mode: "0644",
      variables: { user: "deploy", group: "deploy", cwd: "/home/deploy/apps/dude/current" }
    )
  end

  it "should start the dude service" do
    expect(chef_run).to start_service("dude").with(
      action: [:enable, :start],
      provider: Chef::Provider::Service::Upstart,
      supports: { restart: true, status: true }
    )
  end
end
