#
# Cookbook Name:: dude
# Recipe:: ejson
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

ejson_keys     = Chef::EncryptedDataBagItem.load("ejson", "keys")
deploy_account = "deploy"

directory "/opt/ejson/keys" do
  recursive true
  owner deploy_account
  group deploy_account
  mode 660
end

directory "/code" do
  recursive true
  owner deploy_account
  group deploy_account
  mode 700
end

node["apps"].each do |app_name|
  app = Chef::EncryptedDataBagItem.load("apps", app_name)
  app.fetch("ejson_keys", []).each do |key|
    data = ejson_keys[key]

    file "/opt/ejson/keys/#{data['public']}" do
      content data["private"]
      owner deploy_account
      group deploy_account
      mode 440
    end
  end
end
