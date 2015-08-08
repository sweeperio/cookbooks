#
# Cookbook Name:: dude
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dude::default" do
  before do
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("ejson", "keys").and_return([])
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("tokens", "github").and_return([])
  end

  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  %w(dude::apps).each do |recipe|
    it "should include the #{recipe} recipe" do
      expect(chef_run).to include_recipe(recipe)
    end
  end
end
