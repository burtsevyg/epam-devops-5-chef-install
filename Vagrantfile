Vagrant.configure("2") do |config|
  config.vm.define "dk" do |dk|
    dk.vm.box = "ubuntu/xenial64"
    dk.vm.provider "VirtualBox"
    dk.vm.network "private_network", ip: "192.168.0.2"
    dk.vm.hostname = "dk"
    dk.vm.provision "shell", path: "chef-dk-install.sh"
  end

  config.vm.define "server" do |server|
    server.vm.box = "ubuntu/xenial64"
    server.vm.provider "VirtualBox"
    server.vm.network "private_network", ip: "192.168.0.3"
    server.vm.hostname = "chefdk"
    server.vm.provision "shell", path: "chef-server-install.sh"
  end

  config.vm.define "node" do |node|
    node.vm.box = "ubuntu/xenial64"
    node.vm.provider "VirtualBox"
    node.vm.network "private_network", ip: "192.168.0.4"
    node.vm.hostname = "chefdk"
    node.vm.provision "shell", path: "chef-node-install.sh"
  end
end