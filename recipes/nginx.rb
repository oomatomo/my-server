#
# Cookbook Name:: my-server
# Recipe:: Nginx
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

package "nginx" do
  action [:install, :upgrade]
  notifies :restart, "service[nginx]", :delayed
end

service "nginx" do
  action [:enable, :start]
  supports :restart => true
end
