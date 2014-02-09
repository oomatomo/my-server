action :run do
  execute new_resource.name do
    user node['user']
    group node['group']
    environment ({
      'PERLBREW_ROOT' => node['perlbrew']['home'],
      'PERLBREW_HOME' => "#{node['home']}/.perlbrew",
      'HOME' => node['home']
    })
    command new_resource.command
    action :run
  end
end
