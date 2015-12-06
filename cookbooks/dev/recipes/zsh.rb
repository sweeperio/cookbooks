#
# Cookbook Name:: dev
# Recipe:: zsh
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "zsh"

cookbook_file "/etc/zsh/zshenv" do
  source "zshenv"
end
