#
# Cookbook Name:: dev
# Spec:: postgresql
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dev::postgresql" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "should create the create user sql file" do
    expect(chef_run).to create_cookbook_file("/tmp/vagrant_user.sql")
  end

  it "should execute the sql file" do
    file = chef_run.cookbook_file("/tmp/vagrant_user.sql")
    expect(file).to notify("execute[create vagrant user]").to(:run).delayed
  end
end
