#
# cookbook name:: my-server
# recipe:: rbenv
#
# copyright (c) 2013 omagari tomohisa
#
# all rights reserved - do not redistribute
#

%w{openssl-devel zlib-devel readline-devel libxml2-devel libxslt-devel}.each do |p|
  package p
end

rbenv_home = node['rbenv']['home']

git rbenv_home do
  repository "https://github.com/sstephenson/rbenv.git"
  reference "master"
  user node['user']
  group node['group']
  action :checkout
  not_if {::File.exists?(rbenv_home)}
end

directory "#{rbenv_home}/plugins" do
  owner node['user']
  group node['group']
  mode 00744
  action :create
end

git "#{rbenv_home}/plugins/ruby-build" do
  repository "https://github.com/sstephenson/ruby-build.git"
  reference "master"
  user node['user']
  group node['group']
  action :checkout
  not_if {::File.exists?("#{rbenv_home}/plugins/ruby-build")}
end

node['rbenv']['versions'].each do |v|
  execute "ruby install #{v}" do
    user node['user']
    group node['group']
    environment ( { 'RBENV_ROOT' => rbenv_home } )
    path ["#{rbenv_home}/bin/:$PATH"]
    command "#{rbenv_home}/bin/rbenv install #{v}"
    not_if {::File.exists?("#{rbenv_home}/versions/#{v}")}
  end
end

if node['rbenv']['global']

  execute "set up global ruby version #{node['rbenv']['global']}" do
    user node['user']
    group node['group']
    environment ( { 'HOME' => node['home'], 'RBENV_ROOT' => rbenv_home, 'RBENV_VERSION' => node['rbenv']['global'] } )
    path ["#{rbenv_home}/bin/:$PATH"]
    command <<-EOH
      #{rbenv_home}/bin/rbenv global #{node['rbenv']['global']}
    EOH
    only_if {::File.exists?("#{rbenv_home}/versions/#{node['rbenv']['global']}")}
  end

  node['rbenv']['gems'].each do |g|
    execute "gem install #{g}" do
      user node['user']
      group node['group']
      environment ( { 'HOME' => node['home'], 'RBENV_ROOT' => rbenv_home, 'RBENV_VERSION' => node['rbenv']['global'] } )
      path ["#{rbenv_home}/shims/:$PATH"]
      command "#{rbenv_home}/shims/gem i #{g} --no-ri --no-rdoc"
    end
  end

end
