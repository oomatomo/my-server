name             'my-server'
maintainer       'Omagari Tomohisa'
maintainer_email 'oomatomo@gmail.com'
license          'All rights reserved'
description      'Installs/Configures my-server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "zsh"
depends "git", "~> 2.6.0"
depends "mysql", "~> 3.0.0"
depends "database", "~> 1.5.0"
depends "memcached", "~> 1.7.0"
