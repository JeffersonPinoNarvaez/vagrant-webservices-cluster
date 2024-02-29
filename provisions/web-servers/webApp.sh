#!/bin/bash

#Manage errors.
set -e

#Scope variables
ip_address=$(hostname -I | awk '{print $2}')
server_port=3000

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
echo -e "\n\n🚀 Install and configure our web services in the server $ip_address... 🛠️"

echo -e "\n\nUpdating our server repo..."
sudo apt update -y && sudo apt upgrade -y

echo -e "\n\nInstalling nodeJs..."
sudo apt install nodejs -y

echo -e "\n\nInstalling and npm..."
sudo apt install npm -y

echo -e "\n\nCopying our demo nodeJs example into our server..."
sudo cp -r /home/vagrant/sharedFolder/webService /home/
sed -i "s/const HOST='.*'/const HOST='$ip_address'/" /home/webService/app/index.js
cd /home/webService/app

echo -e "\n\nInstalling express..."
sudo npm install express -y

echo -e "\n\nInstalling consul..."
sudo npm install consul

echo -e "\n\nInstalling pm2 to manage our nodejs demon....."
npm install -g pm2 -y

echo -e "\n\nStarting our nodeJs web server in the port $server_port"
sudo pm2 -f start /home/webService/app/index.js -- 3000
sudo pm2 -f start /home/webService/app/index.js -- 3001
sudo pm2 startup