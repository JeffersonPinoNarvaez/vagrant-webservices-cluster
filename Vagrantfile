# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install  = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote   = true
  end

  config.vm.define :webApp1 do |webApp1|
    webApp1.vm.box = "bento/ubuntu-22.04"
    webApp1.vm.network :private_network, ip: "192.168.100.10"
    webApp1.vm.hostname = "webApp1"
    webApp1.vm.provision "shell", path: "./webApp1.sh"
    webApp1.vm.synced_folder "./sharedFolder", "/home/vagrant/sharedFolder"   
  end

  config.vm.define :webApp2 do |webApp2|
    webApp2.vm.box = "bento/ubuntu-22.04"
    webApp2.vm.network :private_network, ip: "192.168.100.11"
    webApp2.vm.hostname = "webApp2"
    webApp2.vm.provision "shell", path: "./webApp2.sh"
    webApp2.vm.synced_folder "./sharedFolder", "/home/vagrant/sharedFolder"   
  end

  config.vm.define :webApp3 do |webApp3|
    webApp3.vm.box = "bento/ubuntu-22.04"
    webApp3.vm.network :private_network, ip: "192.168.100.12"
    webApp3.vm.hostname = "webApp3"
    webApp3.vm.provision "shell", path: "./webApp3.sh"
    webApp3.vm.synced_folder "./sharedFolder", "/home/vagrant/sharedFolder"   
  end
    
  config.vm.define :balancerServer do |balancerServer|
    balancerServer.vm.box = "bento/ubuntu-22.04"
    balancerServer.vm.network :private_network, ip: "192.168.100.20"
    balancerServer.vm.hostname = "balancerServer"
    balancerServer.vm.provision "shell", path: "./balancerServer.sh"
    config.vm.synced_folder "./sharedFolder", "/home/vagrant/sharedFolder"
  end
end