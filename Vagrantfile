# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.hostname = "grafana-graphite-stack-puppet-profile.vm"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2000"
  end

  config.vm.define "centos6" do |centos6|
    centos6.vm.box = "puppetlabs/centos-6.6-64-nocm"
  end

  config.vm.define "centos7" do |centos7|
    centos7.vm.box = "puppetlabs/centos-7.0-64-nocm"
  end

  config.vm.network "private_network", ip: "192.168.10.50"

  # Install Ruby
  config.vm.provision "shell", inline: <<-SHELL
    curl -s https://packagecloud.io/install/repositories/petems/ruby2/script.rpm.sh | sudo bash
    yum install -y ruby curl
  SHELL

  # Use r10k to download modules
  config.vm.provision "shell", inline: <<-SHELL
    yum install -y epel-release git nss curl libcurl
    gem install r10k --no-ri --no-rdoc
    cd /vagrant/ && r10k puppetfile install -v
  SHELL

  config.vm.provision "shell", inline: <<-SHELL
    wget -O - https://raw.githubusercontent.com/petems/puppet-install-shell/master/install_puppet_5_agent.sh | sudo sh
  SHELL

  # Use Vagrant provisioner to run puppet
  config.vm.provision :puppet do |puppet|
    puppet.environment_path = "environments"
    puppet.environment = "vagrant"
    # puppet.options = "--verbose --debug" # Uncomment for debugging
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Simulating some load to make the graphs more interesting";
    curl -s https://packagecloud.io/install/repositories/petems/stress/script.rpm.sh | sudo bash;
    yum install -y stress;
    stress --cpu 1 --timeout 60;
    echo "Download file to create network traffic";
    wget http://ipv4.download.thinkbroadband.com/50MB.zip --quiet;
  SHELL

  config.vm.provision "shell", inline: <<-SHELL
    service iptables stop || service firewalld stop;
    echo "Grafana is running at http://192.168.10.50:3000";
    echo "Username and password: admin:admin";
  SHELL

end
