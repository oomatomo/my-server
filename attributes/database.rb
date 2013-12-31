default['database']['host'] = '127.0.0.1'

# for mysql cookbook
default['mysql']['server_root_password'] = 'root'
default['mysql']['server_debian_password'] = 'root'
default['mysql']['server_repl_password'] = 'root'
default['mysql']['bind_address'] = default['database']['host']
