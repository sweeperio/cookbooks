#
# Cookbook Name:: base
# Recipe:: chruby
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "chruby::system"

node["chruby"]["rubies"].each do |ruby, installed|
  next unless installed

  execute "install bundler for ruby #{ruby}" do
    command "/opt/rubies/#{ruby}/bin/gem install bundler"
    not_if { ::File.exists?("/opt/rubies/#{ruby}/bin/bundle") }
  end
end
