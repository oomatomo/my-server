#
# Cookbook Name:: my-server
# Recipe:: memcached
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

%w{memcached libmemcached-devel}.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end

service 'memcached' do
  action :nothing
  supports :restart => true
end

template '/etc/sysconfig/memcached' do
  source "memcached.sysconfig.erb"
  owner 'root'
  group 'root'
  mode  '0644'
  variables(
    :listen      => node['memcached']['listen'],
    :user        => node['memcached']['user'],
    :port        => node['memcached']['port'],
    :udp_port    => node['memcached']['udp_port'],
    :maxconn     => node['memcached']['maxconn'],
    :memory      => node['memcached']['memory'],
    :logfilename => node['memcached']['logfilename']
  )
  notifies :restart, 'service[memcached]'
end
