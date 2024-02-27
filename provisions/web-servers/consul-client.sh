#!/bin/bash

#Manage errors.
set -e

# Scope variables
ip_address=$(hostname -I | awk '{print $2}')
hostname=$(hostname)
consul_server="192.168.100.10"

echo -e "\n\n🔑 Downloading and adding HashiCorp GPG key, and adding HashiCorp repository to package manager..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo -e "\n\n🔄 Updating the package manager and installing Consul..."
sudo apt update && sudo apt install consul -y

echo -e "\n\n🚀 Starting the Consul agent as a background process..."
nohup consul agent \
  -node="agent-$hostname" \
  -bind="$ip_address" \
  -enable-script-checks=true \
  -data-dir=/tmp/consul \
  -config-dir=/etc/consul.d \
  >/dev/null 2>&1 &

echo -e "\n\n🤝 Joining the Consul cluster with the specified server..."
consul join $consul_server

echo -e "\n\n✅ Consul agent-$hostname joined successfully."