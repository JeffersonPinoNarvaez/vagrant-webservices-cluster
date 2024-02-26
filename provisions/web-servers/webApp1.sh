#!/bin/bash

# Definir el nuevo valor de HOST
NEW_HOST="192.168.100.10"

sudo apt update
sudo apt upgrade
sudo apt install nodejs -y
node -v
sudo apt install npm -y
npm -v

sudo apt install git -y
git --version

sudo cp -r /home/vagrant/sharedFolder/webService1 /home/
sed -i "s/const HOST='.*'/const HOST='$NEW_HOST'/" /home/webService1/app/index.js
cd /home/webService1/app


sudo npm install consul -y
sudo npm install express -y
node index.js 3000