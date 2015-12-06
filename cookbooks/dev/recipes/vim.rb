#
# Cookbook Name:: dev
# Recipe:: vim
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

VIM_VERSION  = "7-4-589"
VIM_CHECKSUM = "b3d320d5e103fb2bbfafc7f167970a576148baa6ce3521e8d08a2edd42532420"

ark "vim" do
  url "https://github.com/b4winckler/vim/archive/v#{VIM_VERSION}.tar.gz"
  version VIM_VERSION
  checksum VIM_CHECKSUM
  autoconf_opts %w(--enable-pythoninterp --enable-rubyinterp)
  action :install_with_make
end
