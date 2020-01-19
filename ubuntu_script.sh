#!/bin/sh
add-apt-repository ppa:ansible/ansible
/usr/bin/apt-get -y update
/usr/bin/apt-get -y upgrade
/usr/bin/apt-get -y install vim
# /usr/bin/apt-get -y install vim ansible
# create ssh-key
/usr/bin/ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
/bin/cp $HOME/.ssh/id_rsa* /home/vagrant/.ssh/
/bin/chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*
/bin/chmod 400 /home/vagrant/.ssh/id_rsa
/bin/cat /home/vagrant/.ssh/id_rsa.pub >> /vagrant/ubuntu_keys.txt
