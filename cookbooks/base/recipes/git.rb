#
# Cookbook Name:: base
# Recipe:: git
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

GIT_VERSION  = "2.4.4"
GIT_CHECKSUM = "e41ee03f0d3efc671b1280ad88fcfe4073aef3470f65eb282b07cf682cf61975"

%w(libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev).each do |pkg|
  package pkg
end

ark "git" do
  url "https://nodeload.github.com/git/git/tar.gz/v#{GIT_VERSION}"
  version GIT_VERSION
  checksum GIT_CHECKSUM
  extension "tar.gz"
  make_opts %w(prefix=/usr/local)
  action :install_with_make
end
