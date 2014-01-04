#
# Cookbook Name:: my-server
# Recipe:: database
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

if node['platform_family'] == 'rhel'

  tar_name = node['mysql']['tar_name']
  rpm_name = "#{node['mysql']['full_version']}.el6.#{node['kernel']['machine']}"

  package "mysql" do
    action :remove
  end

  remote_file "#{Chef::Config['file_cache_path']}/#{tar_name}" do
    source node['mysql']['download_url']
    notifies :run, "execute[tar mysql file]", :immediately
  end

  execute "tar mysql file" do
    cwd Chef::Config[:file_cache_path]
    command "tar xf #{tar_name}"
    action :nothing
    notifies :install, "package[MySQL-shared-compat]", :immediately
  end

  package "MySQL-shared-compat" do
    action :nothing
    source "#{Chef::Config[:file_cache_path]}/MySQL-shared-compat-#{rpm_name}.rpm"
    notifies :install, "package[MySQL-server]", :immediately
  end

  package "MySQL-server" do
    action :nothing
    source "#{Chef::Config[:file_cache_path]}/MySQL-server-#{rpm_name}.rpm"
    notifies :install, "package[MySQL-client]", :immediately
  end

  package "MySQL-client" do
    action :nothing
    source "#{Chef::Config[:file_cache_path]}/MySQL-client-#{rpm_name}.rpm"
    notifies :install, "package[MySQL-devel]", :immediately
  end

  package "MySQL-devel" do
    action :nothing
    source "#{Chef::Config[:file_cache_path]}/MySQL-devel-#{rpm_name}.rpm"
    notifies :restart, "service[mysql]", :delayed
  end

  service "mysql" do
    action [:enable, :start]
    supports :restart => true
  end

end
