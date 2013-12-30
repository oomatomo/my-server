#
# Cookbook Name:: my-server
# Recipe:: perlbrew
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

directory node['perlbrew']['perlbrew_root'] do
  owner "vagrant"
  group "vagrant"
  mode 00644
  action :create
end

include_recipe "perlbrew::default"
