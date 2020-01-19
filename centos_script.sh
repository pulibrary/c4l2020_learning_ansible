#!/bin/sh
/usr/bin/yum install epel-release
/usr/bin/yum -y update
/usr/bin/yum -y install vim
# yum -y install vim ansible
/usr/bin/ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
/usr/bin/cp $HOME/.ssh/id_rsa* /home/vagrant/.ssh/
/usr/bin/chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*
/usr/bin/chmod 400 /home/vagrant/.ssh/id_rsa
/usr/bin/cat /home/vagrant/.ssh/id_rsa.pub >> /vagrant/centos_keys.txt
