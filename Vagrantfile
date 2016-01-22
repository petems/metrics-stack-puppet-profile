# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "puppetlabs/centos-6.6-64-puppet"
  config.vm.hostname = "metrics-stack-puppet-profile.vm"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2000"
  end

  config.vm.network "public_network"

  config.vm.provision "shell", inline: <<-SHELL
  SHELL

end
