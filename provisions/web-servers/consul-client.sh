#!/bin/bash

# Scope variables
ip_address=$(hostname -I | awk '{print $2}')
hostname=$(hostname)
consul_server="192.168.100.10"

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
echo -e "\n\n🚀 Install and configure our consul clients in the server $ip_address... 🛠️"

echo -e "\n\n🔑 Downloading and adding HashiCorp GPG key, and adding HashiCorp repository to package manager..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo -e "\n\n🔄 Updating the package manager and installing Consul..."
sudo apt update && sudo apt install consul -y

echo -e "\n\n🚀 Starting and Joining the Consul cluster as a background process..."
nohup consul agent -node=consul-client-$hostname -bind=$ip_address -data-dir=/var/consul -retry-join=$consul_server >/dev/null 2>&1 &

echo -e "\n\n✅ $hostname Consul agent joined successfully."