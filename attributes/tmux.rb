
default[:tmux][:version] = '1.8'

default[:tmux][:sources] = %w{libevent tmux}

default[:tmux][:source][:libevent][:name] = "libevent-2.0.21-stable"
default[:tmux][:source][:libevent][:checksum] = "22a530a8a5ba1cb9c080cba033206b17dacd21437762155c6d30ee6469f574f5"
default[:tmux][:source][:libevent][:url] = "https://github.com/downloads/libevent/libevent/#{node[:tmux][:source][:libevent][:name]}.tar.gz"

default[:tmux][:source][:tmux][:name] = "tmux-#{node[:tmux][:version]}"
default[:tmux][:source][:tmux][:checksum] = 'f265401ca890f8223e09149fcea5abcd6dfe75d597ab106e172b01e9d0c9cd44'
default[:tmux][:source][:tmux][:url] = "http://downloads.sourceforge.net/tmux/#{node[:tmux][:source][:tmux][:name]}.tar.gz"
