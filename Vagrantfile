# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install  = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote   = true
  end

  (1..3).each do |i|
    config.vm.define "webApp#{i}" do |agent|
      agent.vm.box = "bento/ubuntu-22.04"
      agent.vm.network "private_network", ip: "192.168.100.1#{i}"
  
      agent.vm.provision "shell", path: "./provisions/web-servers/webApp.sh", env: {
        "NOMBRE" => "#{i}",
        "IP_DEL_AGENTE" => "192.168.100.1#{i+1}"
      }
    end
  end

  config.vm.define :balancerServer do |balancerServer|
    balancerServer.vm.box = "bento/ubuntu-22.04"
    balancerServer.vm.network :private_network, ip: "192.168.100.20"
    balancerServer.vm.hostname = "balancerServer"
    balancerServer.vm.provision "shell", path: "./provisions/web-balancer/balancerServer.sh"
    balancerServer.vm.synced_folder "./sharedFolder", "/home/vagrant/sharedFolder"
  end
end
