#
# Cookbook Name:: dev
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dev::zsh" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "includes the main (external) zsh recipe" do
    expect(chef_run).to include_recipe("zsh")
  end

  it "sets up a default zshenv" do
    expect(chef_run).to create_cookbook_file("/etc/zsh/zshenv")
  end
end
