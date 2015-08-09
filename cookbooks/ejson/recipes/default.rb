#
# Cookbook Name:: ejson
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

directory "/opt/ejson/keys" do
  recursive true
  owner node["ejson"]["owner"]
  group node["ejson"]["group"]
  mode "0550"
end

include_recipe "ejson::keys"
