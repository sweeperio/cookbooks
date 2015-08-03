#
# Cookbook Name:: base
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "base::default" do
  INCLUDED_RECIPES = %w(apt base::packages base::chruby)

  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new

    stub_command("git --version >/dev/null").and_return("2.4.4")
    runner.converge(described_recipe)
  end

  INCLUDED_RECIPES.each do |recipe|
    it "includes the #{recipe} recipe" do
      expect(chef_run).to include_recipe(recipe)
    end
  end

  it "creates the sudoers group" do
    expect(chef_run).to create_group("sudoers")
  end
end
