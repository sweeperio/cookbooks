#
# Cookbook Name:: base
# Recipe:: packages
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

node["packages"].each do |package_name|
  package package_name
end
