# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "puppetlabs/centos-6.6-64-puppet"
  config.vm.hostname = "metrics-stack-puppet-profile.vm"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2000"
  end

  config.vm.network "public_network"

  # Install Ruby
  config.vm.provision "shell", inline: <<-SHELL
    curl -s https://packagecloud.io/install/repositories/petems/ruby2/script.rpm.sh | sudo bash
    yum install -y ruby
  SHELL

  # Use r10k to download modules
  config.vm.provision "shell", inline: <<-SHELL
    yum install -y epel-release git
    gem install r10k --no-ri --no-rdoc
    cd /vagrant/ && r10k puppetfile install -v
  SHELL

  # Use Vagrant provisioner to run puppet
  config.vm.provision :puppet do |puppet|
    puppet.environment_path = "environments"
    puppet.environment = "vagrant"
    # puppet.options = "--verbose --debug" # Uncomment for debugging
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Simulating some load to make the graphs more interesting"
    yum install -y stress
    stress --cpu 1 --timeout 60
  SHELL

  config.vm.provision "shell", inline: <<-SHELL
    service iptables stop # Could do this with Puppet, but feeling lazy
    echo "Grafana is running at http://`facter ipaddress`:3000"
    echo "Username and password: admin:admin"
  SHELL

end
