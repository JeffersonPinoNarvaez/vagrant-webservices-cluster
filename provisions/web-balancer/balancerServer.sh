#!/bin/bash

ip_address=$(hostname -I | awk '{print $2}')
echo "La dirección IP de la máquina virtual es: $ip_address"

sudo apt update -y
sudo apt upgrade -y
sudo apt install haproxy -y
sudo systemctl enable haproxy


sudo rsync -avz -e ssh /vagrant/configurations/haproxy.cfg vagrant@$ip_address:/etc/haproxy/haproxy

sudo systemctl restart haproxy