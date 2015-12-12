#
# Cookbook Name:: dev
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dev::default" do
  RECIPES = %w(postgresql hub vim zsh nginx)

  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "includes recipes" do
    RECIPES.each do |recipe|
      expect(chef_run).to include_recipe("dev::#{recipe}")
    end
  end

  it "sets the default shell for the vagrant user" do
    expect(chef_run).to run_execute("set default shell")
  end
end
