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
bash "perlbrew self-upgrade" do
  user node['user']
  group node['group']
  environment ({'PERLBREW_ROOT' => perlbrew_home})
  code <<-EOH
  #{perlbrew_bin} self-upgrade
  #{perlbrew_bin} -f install-patchperl
  #{perlbrew_bin} -f install-cpanm
  EOH
  only_if {::File.exists?(perlbrew_bin) and node['perlbrew']['self_upgrade']}
end

# if not, install it
bash "perlbrew-install" do
  user node['user']
  group node['group']
  environment ({'PERLBREW_ROOT' => perlbrew_home})
  code <<-EOH
  curl -L http://install.perlbrew.pl | bash
  #{perlbrew_bin} -f install-patchperl
  #{perlbrew_bin} -f install-cpanm
  EOH
  not_if {::File.exists?(perlbrew_bin)}
end

# were any perls requested in attributes?
if node['perlbrew']['perls']
  node['perlbrew']['perls'].each do |p|
    bash "install perlbrew perl #{p}" do
      user node['user']
      group node['group']
      environment ({'PERLBREW_ROOT' => perlbrew_home})
      code "#{perlbrew_home}/bin/perlbrew install #{p}"
      not_if {::File.exists?("#{perlbrew_home}/perls/#{p}")}
    end
  end
end
