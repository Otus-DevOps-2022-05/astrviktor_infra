#!/bin/bash

wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb https://mirrors.aliyun.com/mongodb/apt/ubuntu xenial/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod

#sudo apt -y install docker docker.io
#sudo systemctl enable docker
#sudo systemctl start docker
#sudo docker run --detach \
#  --publish 27017:27017 \
#  --name mongodb \
#  --restart always \
#mongo:4.2
