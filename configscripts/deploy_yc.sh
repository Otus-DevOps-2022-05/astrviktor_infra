#!/bin/bash

echo "================="
echo "Installing Ruby"
echo "================="

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
ruby -v
bundler -v

echo "================="
echo "Ready Ruby"
echo "================="


echo "================="
echo "Installing Mongo"
echo "================="

wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb https://mirrors.aliyun.com/mongodb/apt/ubuntu xenial/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod

echo "================="
echo "Ready Mongo"
echo "================="


echo "================="
echo "Installing App"
echo "================="

sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d

echo "================="
echo "Ready App"
echo "================="
