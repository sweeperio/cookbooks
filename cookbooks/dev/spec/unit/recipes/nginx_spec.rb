#
# Cookbook Name:: dev
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dev::nginx" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "defines an nginx site for development" do
    expect(chef_run).to create_nginx_site("dev-rails-nginx.conf.erb")
    expect(chef_run).to enable_nginx_site("dev-rails-nginx.conf.erb")
  end

  it "symlinks /usr/local/bin/luajit to openresty's vendored implementation" do
    expect(chef_run).to create_link("/usr/local/bin/luajit").with(
      to: "/usr/local/openresty/luajit/bin/luajit-2.1.0-alpha"
    )
  end
end
