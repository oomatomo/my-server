#
# Cookbook Name:: my-server
# Recipe:: tmux
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

%w{ncurses ncurses-devel}.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end

libevent = "libevent-#{node[:tmux][:libevent][:version]}-stable"
tmux = "tmux-#{node[:tmux][:version]}"

remote_file "#{Chef::Config['file_cache_path']}/#{libevent}.tar.gz" do
  action :create_if_missing
  source   "https://github.com/downloads/libevent/libevent/#{libevent}.tar.gz"
  checksum node[:tmux][:libevent][:checksum]
  notifies :run, 'bash[install_libevent]', :immediately
end

bash 'install_libevent' do
  user 'root'
  cwd  Chef::Config['file_cache_path']
  code <<-EOH
      tar -zxf #{libevent}.tar.gz
      cd #{libevent}
      ./configure && make && make install
    EOH
  action :nothing
  notifies :create, "remote_file[#{Chef::Config['file_cache_path']}/#{tmux}.tar.gz]", :immediately
end

remote_file "#{Chef::Config['file_cache_path']}/#{tmux}.tar.gz" do
  action :nothing
  source   "http://downloads.sourceforge.net/tmux/#{tmux}.tar.gz"
  checksum node[:tmux][:checksum]
  notifies :run, 'bash[install_tmux]', :immediately
end

bash 'install_tmux' do
  user 'root'
  cwd  Chef::Config['file_cache_path']
  code <<-EOH
      tar -zxf #{tmux}.tar.gz
      cd #{tmux}
      ./configure && make && make install
    EOH
  action :nothing
end
