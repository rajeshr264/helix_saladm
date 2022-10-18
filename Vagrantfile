# multi node CentOS 7 cluster 
Vagrant.configure('2') do |config|
  config.vm.define "p4server" do |subconfig|
    subconfig.vm.box = 'centos/7'
    subconfig.ssh.forward_agent = true
    subconfig.vm.network "private_network", ip: "192.168.50.4"
    subconfig.vm.provision "shell",
      inline: "hostnamectl set-hostname p4server.lab"
  end
  
  config.vm.define "p4client" do |subconfig|
    subconfig.vm.box = 'centos/7'
    subconfig.ssh.forward_agent = true
    subconfig.vm.network "private_network", ip: "192.168.50.5"
    subconfig.vm.provision "file", source: "./.vagrant/machines/p4server/virtualbox/private_key", 
      destination: "/tmp/server_key"
    subconfig.vm.provision "shell",
      inline: "hostnamectl set-hostname p4client.lab"
  end
end