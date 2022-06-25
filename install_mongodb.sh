#!/bin/bash
sudo apt-get install -y mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb

#sudo apt -y install docker docker.io
#sudo systemctl enable docker
#sudo systemctl start docker
#sudo docker run --detach \
#  --publish 27017:27017 \
#  --name mongodb \
#  --restart always \
#mongo:4.2

#sudo apt install -y git
#sudo apt install -y openvpn
#sudo apt install -y python
#sudo apt install -y python2
#wget https://raw.githubusercontent.com/ruped24/autovpn2/master/autovpn2.py
#sudo mv autovpn2.py /usr/local/bin/autovpn2
#sudo chmod +x /usr/local/bin/autovpn2
#sudo /usr/local/bin/autovpn2 KR &
#sleep 10
#wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
#echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
#sudo apt-get update
#sudo apt-get install -y mongodb-org
#sudo systemctl start mongod
#sudo systemctl enable mongod
