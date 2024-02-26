#!/bin/bash

# Definir el nuevo valor de HOST
NEW_HOST="192.168.100.11"

sudo apt update
sudo apt upgrade
sudo apt install nodejs -y
node -v
sudo apt install npm -y
npm -v

sudo apt install git -y
git --version

sudo cp -r /home/vagrant/sharedFolder/webService2 /home/
sed -i "s/const HOST='.*'/const HOST='$NEW_HOST'/" /home/webService2/app/index.js
cd /home/webService2/app


sudo npm install consul -y
sudo npm install express -y
node index.js 3000