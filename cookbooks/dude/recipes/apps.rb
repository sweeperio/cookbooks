#
# Cookbook Name:: dude
# Recipe:: ejson
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
MISSING_KEY_MESSAGE = "One or more ejson keys are missing from node[\"ejson\"][\"keys\"][\"add\"]"

deploy_tokens  = Chef::EncryptedDataBagItem.load("tokens", "github")
deploy_account = "deploy"

apps      = node["apps"].map { |name| Chef::EncryptedDataBagItem.load("apps", name).to_hash }
node_keys = node["ejson"]["keys"].fetch("add", [])
app_keys  = apps.map { |settings| settings.fetch("ejson_keys", []) }.flatten.compact

# all app ejson keys should be part of this provision
Chef::Application.fatal!(MISSING_KEY_MESSAGE) if (app_keys - node_keys).any?

directory "/home/#{deploy_account}/.ssh" do
  owner deploy_account
  group deploy_account
  mode "0700"
end

execute "add github.com to known_hosts" do
  command "ssh-keyscan -H github.com >> /home/#{deploy_account}/.ssh/known_hosts"
  user deploy_account
  group deploy_account
  action :nothing
end

apps.each do |app|
  name = app.fetch("id")
  repo = app.fetch("github_repo")

  deploy_key "#{name}_deploy_key" do
    provider Chef::Provider::DeployKeyGithub
    action :add
    credentials(token: deploy_tokens["sweeper-deploy"])
    path "/home/#{deploy_account}/.ssh"
    repo repo
    owner deploy_account
    group deploy_account
    mode "0600"
  end

  template "/home/#{deploy_account}/.ssh/#{name}_deploy_key.sh" do
    source "ssh_wrapper.erb"
    owner deploy_account
    group deploy_account
    mode "0750"
    variables key: "/home/#{deploy_account}/.ssh/#{name}_deploy_key"
  end

  # can remove this after it's been run
  directory "/home/#{deploy_account}/repos" do
    action :delete
    recursive true
  end
end
