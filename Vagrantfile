# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "my-server"
  config.vm.box = "CentOS-6.4-x86_64-v20130731"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"

  config.vm.network :private_network, ip: "192.168.30.10"
  config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider :virtualbox do |vb|
     vb.name = "my-server"
     vb.customize ["modifyvm", :id, "--memory", "2048"]
   end

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.berkshelf.berksfile_path = "./Berksfile"
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
        "recipe[my-server::default]",
        "recipe[my-server::tmux]",
        "recipe[perlbrew::default]",
        "recipe[my-server::database]",
        "recipe[memcached]"
    ]
  end
end
