### Workshop and Repository Intro.

## Prior to class

With [Vagrant](https://vagrantup.com) and [Virtualbox](https://virtualbox.org) installed let's discuss the content of this repo. There is a directory called `c4l2020_learning_ansible/vagrantfiles/` which contain two files named `bionicVagrantfile` and `centosVagrantfile`. Take a look at the content of the files and modify lines 7 to have a box count of 3 if you have less than 8GB of memory. So 

```bash
NODE_COUNT = 4
```

will say 

```bash
NODE_COUNT = 3
```
Then

1. Do the following from the root of this repository if you are more familiar with Debian/Ubuntu:

```bash
ln sf ./vagrantfiles/ubuntuVagrantfile ./Vagrantfile
vagrant up
```

1. Do the following from the root of this repository if you are more familiar with RedHat/Centos:

```bash
ln sf ./vagrantfiles/centosVagrantfile ./Vagrantfile
vagrant up
```

Depending on your PC's power and network this process will launch at least 5 Virtual machines

When it completes run

```bash
vagrant halt
```

## More on the repository

We will discuss what [Vagrant](https://vagrantup.com) in brief during the workshop. We will work through installing Ansible from scratch, how it operates at the command line, what the configuration files look like, and how communication works between nodes. This use of Vagrant allows us a lab we can build and tear down without significant penalty.
