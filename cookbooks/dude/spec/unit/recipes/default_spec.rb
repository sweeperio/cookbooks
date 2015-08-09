#
# Cookbook Name:: dude
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dude::default" do
  cached(:chef_run) do
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
end
