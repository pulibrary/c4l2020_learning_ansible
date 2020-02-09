## Ansible Introduction

Before installing ansible we will need to configure the master VM to connect to `c4l20node{1,2,3,4}`. For the purposes of this workshop Ansible uses ssh to connect to the other virtual machines. When you ran `vagrant up` it generated `{centos,ubuntu}_keys.txt` files at the root of the directory. We will be copying the contents of root@master generated keys into all the virtual machines. (Details on how these keys were generated are in the shell script inside the vagrantfiles). If you have run vagrant up a number of times then it is the `root@master` towards the bottom of the file. Repeat these steps on all the VMs.

```bash
vagrant ssh c4l20node4
vagrant@c4l20node4:~$ cat /vagrant/ubuntu_keys.txt
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhXqe2Ja0ato4eG+kCUSuGUTKm57SakdQGO7k0lJHJYgUU0QUB/IByhvA2teiJj2+F3WgiU3Pl9U/QCvTMswRGTcvjEFvGPOGJZfVCiQ+L8zQa9QM1f11tSAXM3mqIIPFUVNHqp42F8w04Q10rVw21eCVXoNSGQzbUIPRyMmHEq6ZDOUwGeH7l0aXzr70tu85XcL5jnoh7adb1y3GAMT7SkESsg05lzs7EpzYMBR+/vwT8YOiqOUScnOhiMJwX1ae2Ztw7rDPh2aoDmXHtF5B5hPmzMN8rlv6yCbDEEvIWhJtD4/B0j+GPpQKWyXrryQHuFu++3634Ck1B1c3eEDaX root@master
```

Log into the master VM with and let's install Ansible and confirm installation with the following commands:

```bash
vagrant ssh master
```

On Ubuntu

```bash
sudo apt-get -y install vim ansible
which ansible
```

On Centos

```bash
sudo yum -y install vim ansible
which ansible
```

Confirm that we can log into all the other nodes with 

```bash
ssh 10.0.15.11
ssh 10.0.15.12
ssh 10.0.15.13
ssh 10.0.15.14
```

### Hello Ansible

The simplest command for ansible is a *local command.* Typically on your master node or local computer. Here is the verbose full command

```bash
ansible all --inventory "localhost," --module-name debug --args "msg='Hello World'"
```

The `ansible` if the name of the executable and we are running ansible against all machines on our `inventory` in this case one using the module name `debug` which echoes to stdout the arguments message `Hello World`. The shortcut for that command which we will be using from here on is

```bash
ansible all -i "localhost," -m debug -a "msg='Hello World'"
localhost | SUCCESS => {
    "msg": "Hello World"
}
```

Let's run a different command:

```bash
ansible all -i "10.0.15.12," -m shell -a "ping -c 3 10.0.15.13"
```

Here we are using the shell module from ansible from the *c4l20node1* VM with the IP `10.0.15.12` to ping the *c4l120node2* VM with the IP `10.0.15.13`. Feel free to repeat that with other IP addresses. As we will demonstrate during the workshop Ansible's "batteries included" means that there's a module called `ping` that we can use.

```bash
ansible all -m shell -a "ping -c 3 localhost"
```

is functionally the same with

```bash
ansible all -m ping
```

The latter has guaranteed idempotency in a way that the former does not. 

Finally let's install the rsync software with 

```bash
ansible all -i "10.0.15.12" -m package  -a "name=rsync state=present" -b
```

this will use the ansible module `package` to install the rsync, the `-b` flag elevates our privilege. Install rsync on the rest of the VMs before we move on to configuring and reducing the number of ansible flags to remember.

### Configure Ansible


