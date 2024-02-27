#!/bin/bash

set -e

echo "
 ___   _______  __   __      ___  _______  _______  _______  _______  ______    _______  _______  __    _  _______  ___   __    _  _______ 
|   | |   _   ||  |_|  |    |   ||       ||       ||       ||       ||    _ |  |       ||       ||  |  | ||       ||   | |  |  | ||       |
|   | |  |_|  ||       |    |   ||    ___||    ___||    ___||    ___||   | ||  |  _____||   _   ||   |_| ||    _  ||   | |   |_| ||   _   |
|   | |       ||       |    |   ||   |___ |   |___ |   |___ |   |___ |   |_||_ | |_____ |  | |  ||       ||   |_| ||   | |       ||  | |  |
|   | |       ||       | ___|   ||    ___||    ___||    ___||    ___||    __  ||_____  ||  |_|  ||  _    ||    ___||   | |  _    ||  |_|  |
|   | |   _   || ||_|| ||       ||   |___ |   |    |   |    |   |___ |   |  | | _____| ||       || | |   ||   |    |   | | | |   ||       |
|___| |__| |__||_|   |_||_______||_______||___|    |___|    |_______||___|  |_||_______||_______||_|  |__||___|    |___| |_|  |__||_______|
 " 
echo -e "\n\n🚀 Install and configure our web load balancer... 🛠️"

echo -e "\n\nUpdating our server repo..."
sudo apt update && apt upgrade -y

echo -e "\n\nInstalling and enabling our haproxy server..."
sudo apt install haproxy -y
sudo systemctl enable haproxy

echo -e "\n\nCopying our already set up haproxy configuration file..."
sudo cp -r /home/vagrant/sharedFolder/haproxy.cfg /etc/haproxy/haproxy.cfg

echo -e "\n\nstarting our haproxy web server..."
sudo systemctl restart haproxy

echo -e "\n\n🚀 Load balancer server was successfully created, configured, and started! 🌟"

CONSUL_VERSION = "1.14.0"

# Script para instalar Consul y configurar el servidor

echo "Instalando Consul..."
wget https://releases.hashicorp.com/consul/#{CONSUL_VERSION}/consul_#{CONSUL_VERSION}_linux_amd64.zip
unzip consul_#{CONSUL_VERSION}_linux_amd64.zip
sudo mv consul /usr/local/bin/
sudo chmod +x /usr/local/bin/consul
sudo mkdir -p /etc/consul.d/bootstrap

# Configuración de Consul para el servidor
echo '{
  "server": true,
  "node_name": "consul-server",
  "bootstrap_expect": 3,
  "data_dir": "/tmp/consul",
  "bind_addr": "192.168.100.20",
  "client_addr": "0.0.0.0",
  "ui": true,
  "connect": {"enabled": true}
}' | sudo tee /etc/consul.d/bootstrap/config.json

# Iniciar Consul como servidor
consul agent -config-dir=/etc/consul.d/bootstrap &
