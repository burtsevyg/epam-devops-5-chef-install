Vagrant.configure("2") do |config|
# Server
  config.vm.define "server" do |server|
    server.vm.box = "ubuntu/xenial64"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = 8192
      vb.cpus = 4
    end
    server.vm.network "private_network", ip: "192.168.0.3"
    server.vm.hostname = "server"

    ssh_pub_key = File.readlines("./.ssh/id_rsa.pub").first.strip
    server.vm.provision 'shell', inline: 'mkdir -p /root/.ssh'
    server.vm.provision 'shell', inline: 'mkdir -p /home/vagrant/.ssh'
    server.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /root/.ssh/authorized_keys"
    server.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys", privileged: false
    server.vm.provision 'shell', inline: "chmod 600 /root/.ssh/authorized_keys"
    server.vm.provision 'shell', inline: "chmod 600 /home/vagrant/.ssh/authorized_keys", privileged: false

    server.vm.provision "shell", path: "dns.sh", privileged: true
    server.vm.provision "shell", path: "chef-server-install.sh", privileged: true
  end

# Workstation
  config.vm.define "ws" do |ws|
    ws.vm.box = "ubuntu/xenial64"
    ws.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end
    ws.vm.network "private_network", ip: "192.168.0.2"
    ws.vm.hostname = "ws"

    ws.vm.provision "file", source: ".ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
    ws.vm.provision "file", source: ".ssh/id_rsa", destination: "/root/id_rsa"
    ws.vm.provision 'shell', inline: "chmod 600 /root/.ssh/id_rsa"
    ws.vm.provision 'shell', inline: "chmod 600 /home/vagrant/.ssh/id_rsa", privileged: false
    ws.vm.provision 'shell', inline: "echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config"
    ws.vm.provision 'shell', inline: "echo 'UserKnownHostsFile /dev/null' >> /etc/ssh/ssh_config"

    ws.vm.provision "shell", path: "dns.sh", privileged: true
    ws.vm.provision "shell", path: "chef-ws-install.sh", privileged: false
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
    client.vm.provision "shell", path: "dns.sh", privileged: true
    client.vm.provision "shell", path: "chef-client-install.sh", privileged: false
  end
end