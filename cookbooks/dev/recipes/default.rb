#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "dev::postgresql"
include_recipe "dev::vim"
include_recipe "dev::zsh"

DEFAULT_SHELL = node["dev"]["shell"]

execute "set default shell" do
  command "chsh -s $(which #{DEFAULT_SHELL}) vagrant"
end
