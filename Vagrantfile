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
  yum install -y epel-release git ftp://rpmfind.net/linux/sourceforge/c/cr/crowbar/core/trunk/ruby-2.1.2-2.el6.x86_64.rpm
  gem install r10k
  cd /vagrant/ && r10k puppetfile install -v
  puppet apply /vagrant/manifests/site.pp
  echo "Simulating some load to make the graphs more interesting"
  yum install -y stress
  stress --cpu 1 --timeout 60
  service iptables stop
  echo "Grafana is running at http://`facter ipaddress`:3000"
  Username and password: admin:admin
  SHELL

end
