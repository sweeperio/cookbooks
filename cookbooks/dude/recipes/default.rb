#
# Cookbook Name:: dude
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

ruby_block "source chruby in bashrc for deploy user" do
  block do
    original_content = IO.read("/home/deploy/.bashrc")
    IO.write("/home/deploy/.bashrc", "source /etc/profile.d/chruby.sh\n#{original_content}")
  end

  action :run
  not_if "grep -q chruby /home/deploy/.bashrc"
end

template "/etc/init/dude.conf" do
  source "dude.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(user: "deploy", group: "deploy", cwd: "/home/deploy/apps/dude/current")
end

service "dude" do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
  supports(restart: true, status: true)
end

include_recipe "dude::apps"
