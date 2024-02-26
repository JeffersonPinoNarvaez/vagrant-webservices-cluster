#!/bin/bash


sudo apt update -y
sudo apt upgrade -y
sudo apt install haproxy -y
sudo systemctl enable haproxy

sudo cp /home/vagrant/sharedFolder/haproxy.cfg /etc/haproxy/haproxy.cfg

sudo systemctl restart haproxy