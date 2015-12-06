#
# Cookbook Name:: dev
# Recipe:: postgresql
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

TEMP_FILE = "/tmp/vagrant_user.sql"

execute "create vagrant user" do
  user "postgres"
  command "psql -f #{TEMP_FILE}"
  action :nothing
end

cookbook_file TEMP_FILE do
  source "vagrant_user.sql"
  notifies :run, "execute[create vagrant user]", :delayed
end
