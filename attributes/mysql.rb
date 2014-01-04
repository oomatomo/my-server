# version
default['mysql']['version'] = '5.6'
default['mysql']['detail_version'] = '15-1'

default['mysql']['full_version'] = "#{default['mysql']['version']}.#{default['mysql']['detail_version']}"

default['mysql']['tar_name'] = "MySQL-#{default['mysql']['full_version']}.el6.#{node['kernel']['machine']}.rpm-bundle.tar"
default['mysql']['download_url'] = "http://dev.mysql.com/get/Downloads/MySQL-#{default['mysql']['version']}/#{default['mysql']['tar_name']}"
