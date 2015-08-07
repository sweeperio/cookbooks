#
# Cookbook Name:: dude
# Recipe:: ejson
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

ejson_keys     = Chef::EncryptedDataBagItem.load("ejson", "keys")
deploy_tokens  = Chef::EncryptedDataBagItem.load("tokens", "github")
deploy_account = "deploy"

directory "/opt/ejson/keys" do
  recursive true
  owner deploy_account
  group deploy_account
  mode "0660"
end

directory "/var/code/.ssh" do
  recursive true
  owner deploy_account
  group deploy_account
  mode "0770"
end

node["apps"].each do |app_name|
  app  = Chef::EncryptedDataBagItem.load("apps", app_name).to_hash
  repo = app.fetch("github_repo")

  deploy_key "#{app_name}_deploy_key" do
    provider Chef::Provider::DeployKeyGithub
    action :add
    credentials(token: deploy_tokens["sweeper-deploy"])
    path "/var/code/.ssh"
    repo repo
    owner deploy_account
    group deploy_account
    mode "0640"
  end

  app.fetch("ejson_keys", []).each do |key|
    data = ejson_keys[key]

    file "/opt/ejson/keys/#{data['public']}" do
      content data["private"]
      owner deploy_account
      group deploy_account
      mode "0440"
    end
  end
end
