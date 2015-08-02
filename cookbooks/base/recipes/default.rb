#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "apt"
include_recipe "build-essential"
include_recipe "base::packages"
include_recipe "base::chruby"
