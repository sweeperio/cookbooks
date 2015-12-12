#
# Cookbook Name:: dev
# Recipe:: nginx
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "open_resty"

open_resty_site "dev-rails-nginx.conf.erb" do
  action [:create, :enable]
end

link "/usr/local/bin/luajit" do
  to "/usr/local/openresty/luajit/bin/luajit-2.1.0-alpha"
end
