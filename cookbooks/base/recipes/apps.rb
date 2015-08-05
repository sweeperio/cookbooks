#
# Cookbook Name:: base
# Recipe:: apps
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

node["apps"].each do |app, settings|
  app_data = Chef::EncryptedDataBagItem.load("apps", app)

  directory settings.fetch("target") do
    mode 0775
    recursive true
    owner "deploy"
    group "deploy"
  end

  app_data["ejson_keys"].each { |key| base_ejson_key(key) }
end
