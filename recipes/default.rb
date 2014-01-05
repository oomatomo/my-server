#
# Cookbook Name:: my-server
# Recipe:: default
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum"
include_recipe "git"
include_recipe "build-essential"

execute "yum update" do
    command <<-EOH
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    yum update -y
    EOH
end

%w{curl wget gcc make vim}.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end
