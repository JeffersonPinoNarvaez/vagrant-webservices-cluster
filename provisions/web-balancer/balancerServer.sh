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

echo -e "\n\nCreating our personalized errors folder"
sudo mkdir -p /etc/haproxy/errors/personalized

echo -e "\n\nCopying our haproxy 503 personalized page.."
sudo cp -r /home/vagrant/sharedFolder/503.http /etc/haproxy/errors/personalized/503.http

echo -e "\n\nCopying our already set up haproxy configuration file..."
sudo cp -r /home/vagrant/sharedFolder/haproxy.cfg /etc/haproxy/haproxy.cfg

echo -e "\n\nstarting our haproxy web server..."
sudo systemctl restart haproxy

echo -e "\n\n🚀 Load balancer server was successfully created, configured, and started! 🌟"