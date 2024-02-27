#!/bin/bash

# Scope variables
ip_address=$(hostname -I | awk '{print $2}')
hostname=$(hostname)

echo -e "\n\n⚙️ Adding HashiCorp GPG key and repository..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo -e "\n\n🔄 Updating package manager and installing Consul..."
sudo apt update && sudo apt install consul -y

echo -e "\n\n🚀 Running Consul agent as a background process..."
nohup consul agent \
  -server \
  -bootstrap-expect=1 \
  -node="agent-$hostname" \
  -bind="$ip_address" \
  -data-dir=/tmp/consul \
  -config-dir=/etc/consul.d \
  >/dev/null 2>&1 &

echo -e "\n\n✅ Consul agent started successfully."