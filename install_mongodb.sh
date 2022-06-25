#!/bin/bash
#sudo apt -y install docker docker.io
#sudo systemctl enable docker
#sudo systemctl start docker
docker run --detach \
  --publish 27017:27017 \
  --name mongodb \
  --restart always \
mongo:4.2
