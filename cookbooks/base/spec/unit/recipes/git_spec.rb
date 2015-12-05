#
# Cookbook Name:: base
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "base::git" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "installs prerequisite packages" do
    %w(libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev).each do |pkg|
      expect(chef_run).to install_package(pkg)
    end
  end

  it "installs and makes git from source" do
    expect(chef_run).to install_with_make_ark("git").with(
      version: "2.4.4",
      make_opts: %w(prefix=/usr/local)
    )
  end
end
