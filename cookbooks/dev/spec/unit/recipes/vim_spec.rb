#
# Cookbook Name:: dev
# Spec:: vim
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dev::vim" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "installs vim via ark" do
    expect(chef_run).to install_with_make_ark "vim"
  end
end
