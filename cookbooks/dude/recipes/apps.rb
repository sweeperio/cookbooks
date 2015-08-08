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

directory "/home/#{deploy_account}/repos" do
  owner deploy_account
  group deploy_account
  mode "0770"
  notifies :run, "execute[add github.com to known_hosts]", :immediately
end

node["apps"].each do |app_name|
  app  = Chef::EncryptedDataBagItem.load("apps", app_name).to_hash
  repo = app.fetch("github_repo")

  deploy_key "#{app_name}_deploy_key" do
    provider Chef::Provider::DeployKeyGithub
    action :add
    credentials(token: deploy_tokens["sweeper-deploy"])
    path "/home/#{deploy_account}/.ssh"
    repo repo
    owner deploy_account
    group deploy_account
    mode "0600"
  end

  template "/home/#{deploy_account}/repos/#{app_name}.sh" do
    source "ssh_wrapper.erb"
    owner deploy_account
    group deploy_account
    mode "0750"
    variables key: "/home/#{deploy_account}/.ssh/#{app_name}_deploy_key"
  end

  git "/home/#{deploy_account}/repos/#{app_name}" do
    action :checkout
    repository "git@github.com:#{repo}.git"
    revision "master"
    ssh_wrapper "/home/#{deploy_account}/repos/#{app_name}.sh"
    user deploy_account
    group deploy_account
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
