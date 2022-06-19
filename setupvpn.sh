#!/bin/bash
echo "deb http://repo.pritunl.com/stable/apt focal main" | sudo tee /etc/apt/sources.list.d/pritunl.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
curl https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | sudo apt-key add -
apt update
apt -y install wireguard wireguard-tools
ufw disable
apt -y install pritunl
systemctl enable pritunl
systemctl start pritunl
apt -y install docker docker.io
systemctl enable docker
systemctl start docker
docker run --detach \
  --publish 27017:27017 \
  --name mongodb \
  --restart always \
mongo:5.0
