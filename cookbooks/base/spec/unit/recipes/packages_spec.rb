#
# Cookbook Name:: base
# Spec:: packages
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "base::packages" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new do |node|
      node.set["packages"] = %w(curl wget)
    end

    runner.converge(described_recipe)
  end

  it "installs packages listed in node['packages']" do
    expect(chef_run).to install_package("curl")
    expect(chef_run).to install_package("wget")
  end
end
