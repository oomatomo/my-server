#
# Cookbook Name:: my-server
# Recipe:: cassandra
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

package 'java-1.6.0-openjdk' do
  action [:install, :upgrade]
end

git "#{Chef::Config['file_cache_path']}/cassandra" do
  repository node['cassandra']['repository_url']
  reference "cassandra-#{node['cassandra']['version']}"
  action :sync
  notifies :run, "execute[set symbolic link]", :immediately
end

execute "set symbolic link" do
  cwd Chef::Config[:file_cache_path]
  command <<-EOH
  ln -sf #{Chef::Config['file_cache_path']}/cassandra #{node['cassandra']['home']}/cassandra
  EOH
  action :nothing
end

