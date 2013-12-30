#
# Cookbook Name:: my-server
# Recipe:: database
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mysql::server'
# for database
include_recipe 'mysql::ruby'
include_recipe 'database::mysql'

# create mysql
#mysql_connection_info = {
#  :host => node['database']['host'],
#  :username => 'root',
#  :password => node['mysql']['server_root_password']
#}
