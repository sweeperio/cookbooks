#
# Cookbook Name:: base
# Spec:: chruby
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "base::chruby" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new do |node, server|
      node.set["chruby"] = {
        "auto_switch" => true,
        "rubies" => {
          "1.9.3-p392" => false,
          "2.2.2" => true
        },
        "default" => "2.2.2"
      }
    end

    stub_command("git --version >/dev/null").and_return("2.4.4")
    runner.converge(described_recipe)
  end

  it "includes chruby::system" do
    expect(chef_run).to include_recipe("chruby::system")
  end

  it "installs bundler for all installed rubies" do
    expect(chef_run).to run_execute("install bundler for ruby 2.2.2")
  end

  it "doesn't attempt to install bundler for uninstalled rubies" do
    expect(chef_run).to_not run_execute("install bundler for ruby 1.9.3-p392")
  end

  it "installs ejson for all installed rubies" do
    expect(chef_run).to run_execute("install ejson for ruby 2.2.2")
  end

  it "doesn't attempt to install ejson for uninstalled rubies" do
    expect(chef_run).to_not run_execute("install ejson for ruby 1.9.3-p392")
  end
end
