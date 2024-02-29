#!/bin/bash

set -e

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
echo -e "\n\n🚀 Install and configure our haproxy web load balancer... 🛠️"

echo -e "\n\nUpdating our server repo..."
sudo apt update && apt upgrade -y

echo -e "\n\nInstalling and enabling our haproxy server..."
sudo apt install haproxy -y
sudo systemctl enable haproxy

echo -e "\n\nCreating our personalized errors folder"
sudo mkdir -p /etc/haproxy/errors/personalized

echo -e "\n\nCopying our haproxy 503 personalized page.."
sudo cp -r /home/vagrant/sharedFolder/503.http /etc/haproxy/errors/personalized/503.http

echo -e "\n\nCopying our already set up haproxy configuration file..."
sudo cp -r /home/vagrant/sharedFolder/haproxy.cfg /etc/haproxy/haproxy.cfg

echo -e "\n\nstarting our haproxy web server..."
sudo systemctl restart haproxy

echo -e "\n\n🚀 Load balancer server was successfully created, configured, and started! 🌟"