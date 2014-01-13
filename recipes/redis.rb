#
# Cookbook Name:: my-server
# Recipe:: redis
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

file_name = 'redis-stable'

remote_file "#{Chef::Config['file_cache_path']}/#{file_name}.tar.gz" do
  source 'http://download.redis.io/redis-stable.tar.gz'
  notifies :run, "execute[tar redis file]", :immediately
end

execute "tar redis file" do
  cwd Chef::Config[:file_cache_path]
  command <<-EOH
  tar xzf #{file_name}.tar.gz
  cd #{file_name}
  make
  make install
  EOH
  action :nothing
end
