#
# Cookbook Name:: my-server
# Recipe:: perlbrew
#
# Copyright (C) 2013 Omagari Tomohisa
#
# All rights reserved - Do Not Redistribute
#

%w{ patch perl curl }.each do |p|
  package p
end

directory node['perlbrew']['home'] do
  owner node['user']
  group node['group']
  mode 00744
  action :create
end

# from https://github.com/aiming-cookbooks/perlbrew/blob/master/recipes/default.rb
perlbrew_home = node['perlbrew']['home']
perlbrew_bin = "#{perlbrew_home}/bin/perlbrew"

# if we have perlbrew, upgrade it
my_server_perlbrew "perlbrew self-upgrade" do
  command <<-EOH
  #{perlbrew_bin} self-upgrade
  #{perlbrew_bin} -f install-patchperl
  #{perlbrew_bin} -f install-cpanm
  EOH
  only_if {::File.exists?(perlbrew_bin) and node['perlbrew']['self_upgrade']}
end

# if not, install it
my_server_perlbrew "perlbrew-install" do
  command <<-EOH
  curl -L http://install.perlbrew.pl | bash
  #{perlbrew_bin} -f install-patchperl
  #{perlbrew_bin} -f install-cpanm
  EOH
  not_if {::File.exists?(perlbrew_bin)}
end

# were any perls requested in attributes?
if node['perlbrew']['perls']
  node['perlbrew']['perls'].each do |p|
    my_server_perlbrew "install perlbrew perl #{p}" do
      command "#{perlbrew_bin} install #{p}"
      not_if {::File.exists?("#{perlbrew_home}/perls/#{p}")}
    end
    if node['perlbrew']['modules']
      node['perlbrew']['modules'].each do |m|
        my_server_perlbrew "install #{m} perl in #{p}" do
          command <<-EOH
          source #{node['perlbrew']['home']}/etc/bashrc
          perlbrew use #{p}
          cpanm install #{m}
          EOH
        end
      end
    end
  end
end


