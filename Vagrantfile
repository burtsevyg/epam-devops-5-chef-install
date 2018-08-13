Vagrant.configure("2") do |config|
# Workstation
  config.vm.define "ws" do |ws|
    ws.vm.box = "ubuntu/xenial64"
    ws.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end
    ws.vm.network "private_network", ip: "192.168.0.2"
    ws.vm.hostname = "ws"
    ws.vm.provision "shell", path: "chef-ws-install.sh", privileged: false
  end

# Server
  config.vm.define "server" do |server|
    server.vm.box = "ubuntu/xenial64"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = 8192
      vb.cpus = 4
    end
    server.vm.network "private_network", ip: "192.168.0.3"
    server.vm.hostname = "chefdk"
    server.vm.provision "shell", path: "chef-server-install.sh", privileged: false
  end

# Client
  config.vm.define "client" do |client|
    client.vm.box = "ubuntu/xenial64"
    client.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end
    client.vm.network "private_network", ip: "192.168.0.4"
    client.vm.hostname = "chefdk"
    client.vm.provision "shell", path: "chef-client-install.sh", privileged: false
  end
end