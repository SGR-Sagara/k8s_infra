#!/bin/bash
# Install Docker
sudo yum update
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user

#Make docker auto-start
sudo chkconfig docker on

#Because you always need it....
sudo yum install -y git

#Install Python 3.8
sudo yum install -y amazon-linux-extras
sudo amazon-linux-extras enable python3.8
sudo yum install python3.8 -y
sudo alias python=python3

# Install pip3
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

#Reboot to verify it all loads fine on its own.
sudo reboot

#docker-compose install
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Configure Git
git config --global user.name "amsagara"
git config --global user.email amsagara@gmail.com

