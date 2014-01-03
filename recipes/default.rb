#
# Cookbook Name:: my-server
# Recipe:: default
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

%w{curl wget gcc make vim}.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end

include_recipe "git"
include_recipe "build-essential"
