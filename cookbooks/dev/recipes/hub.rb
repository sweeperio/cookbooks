#
# Cookbook Name:: dev
# Recipe:: hub
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

HUB_SOURCE  = "https://github.com/github/hub/releases/download"
HUB_VERSION = "2.2.1".freeze

ark "hub" do
  url "#{HUB_SOURCE}/v#{HUB_VERSION}/hub-linux-amd64-#{HUB_VERSION}.tar.gz"
  version HUB_VERSION
  action :cherry_pick
  path "/usr/local/bin"
  creates "hub-linux-amd64-#{HUB_VERSION}/hub"
end
