#
# Cookbook Name:: ejson
# Recipe:: keys
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

ejson_keys     = Chef::EncryptedDataBagItem.load("ejson", "keys")
keys_to_add    = node["ejson"]["keys"].fetch("add", [])
keys_to_remove = node["ejson"]["keys"].fetch("remove", [])

keys_to_add.each do |key|
  file "/opt/ejson/keys/#{ejson_keys[key]["public"]}" do
    content ejson_keys[key]["private"]
    owner node["ejson"]["owner"]
    group node["ejson"]["group"]
    mode "0440"
  end
end

keys_to_remove.each do |key|
  next if ejson_keys[key].nil?
  file("/opt/ejson/keys/#{ejson_keys[key]["public"]}") { action :delete }
end
