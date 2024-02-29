#!/bin/bash

# Scope variables
ip_address=$(hostname -I | awk '{print $2}')
hostname=$(hostname)

echo "
######################################
#                                    #
#         iamjeffersonpino           #
#                                    #
#        created by @devpino         #
#            29-02-2024              #
#                                    #
######################################
"
echo -e "\n\n🚀 Install and configure our consul server in the server $ip_address... 🛠️"

echo -e "\n\n⚙️ Adding HashiCorp GPG key and repository..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo -e "\n\n🔄 Updating package manager and installing Consul..."
sudo apt update && sudo apt install consul -y

echo -e "\n\n🚀 Running and Starting a Consul Server agent as a background process..."

sudo vim /etc/systemd/system/consul.service
nohup consul agent -server -ui -bootstrap-expect=1 -node=consul-server-$hostname -bind=$ip_address -client=0.0.0.0 -data-dir=/var/consul -datacenter=dc1 >/dev/null 2>&1 &

sudo systemctl enable consul
sudo systemctl start consul

echo -e "\n\n✅ $hostname Server Consul agent started successfully."
