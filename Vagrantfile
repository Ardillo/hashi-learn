# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.provider "virtualbox" do |vb|
    #vb.linked_clone = true
    vb.memory = 2048
    vb.cpus = 2
    vb.name = "hashi-learn"
  end

  config.vm.define "server" do |srv|
    srv.vm.hostname = "server01.example.lan"
    srv.vm.network "private_network", ip: "10.0.0.100"

    srv.vm.network "forwarded_port", guest: 3000, host: 3000 # hashi-ui
    srv.vm.network "forwarded_port", guest: 4646, host: 4646 # nomad
    srv.vm.network "forwarded_port", guest: 8201, host: 8201 # vault
    srv.vm.network "forwarded_port", guest: 8500, guest_ip: "localhost", host: 8500 # consul; port doesn't work
    srv.vm.provision "shell", path: "files/base.sh"
    srv.vm.provision "shell", path: "files/docker.sh"

    srv.vm.synced_folder "./files/consul/", "/opt/consul"
    srv.vm.provision "shell", path: "files/consul.sh"

    srv.vm.synced_folder "./files/nomad/", "/opt/nomad"
    srv.vm.provision "shell", path: "files/nomad.sh"

    srv.vm.synced_folder "./files/vault/", "/opt/vault"
    srv.vm.provision "shell", path: "files/vault.sh"

    srv.vm.synced_folder "./files/hashi-ui/", "/opt/hashi-ui"
    srv.vm.provision "shell", path: "files/hashi-ui.sh"
  end

end
