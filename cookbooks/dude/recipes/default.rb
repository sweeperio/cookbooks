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

include_recipe "dude::apps"
