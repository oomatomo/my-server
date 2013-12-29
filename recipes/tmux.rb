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

libevent_name = node[:tmux][:source][:libevent][:name]
tar_name = node[:tmux][:source][:tmux][:name]

remote_file "#{Chef::Config['file_cache_path']}/#{libevent_name}.tar.gz" do
  action :create_if_missing
  source   node[:tmux][:source][:libevent][:url]
  checksum node[:tmux][:source][:libevent][:checksum]
  notifies :run, 'bash[install_libevent]', :immediately
end

bash 'install_libevent' do
  user 'root'
  cwd  Chef::Config['file_cache_path']
  code <<-EOH
      echo #{libevent_name}
      tar -zxf #{libevent_name}.tar.gz
      cd #{libevent_name}
      ./configure && make && make install
    EOH
  action :nothing
  notifies :create, "remote_file[#{Chef::Config['file_cache_path']}/#{tar_name}.tar.gz]", :immediately
end

remote_file "#{Chef::Config['file_cache_path']}/#{tar_name}.tar.gz" do
  action :nothing
  source   node[:tmux][:source][:tmux][:url]
  checksum node[:tmux][:source][:tmux][:checksum]
  notifies :run, 'bash[install_tmux]', :immediately
end

bash 'install_tmux' do
  user 'root'
  cwd  Chef::Config['file_cache_path']
  code <<-EOH
      echo #{tar_name}
      tar -zxf #{tar_name}.tar.gz
      cd #{tar_name}
      ./configure && make && make install
    EOH
  action :nothing
end
