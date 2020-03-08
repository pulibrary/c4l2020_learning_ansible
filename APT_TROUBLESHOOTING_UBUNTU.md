# The Problem

During an invocation of `apt-get install [PACKAGE]`, one receives the following error:
```
W: Failed to fetch gzip:/var/lib/apt/lists/partial/[PACKAGE_SOURCE]  Hash Sum mismatch, 
E: Some index files failed to download. They have been ignored, or old ones used instead.
```

There are several possible approaches to fixing this:

## Using James' Box

Please edit `Vagrantfile`, and replace the BOX variable with the following:
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Every Vagrant development environment requires a box. You can search for
# boxes at https://atlas.hashicorp.com/search.
BOX_IMAGE = "jrgriffiniii/c4l20node1"
NODE_COUNT = 4
```

If you have already built your cluster of Vagrant VM nodes, please just rebuild one with the following:

```bash
vagrant@c4l20node1:~$ vagrant destroy -f c4l20node1
vagrant@c4l20node1:~$ vagrant up c4l20node1
```

Should this be successful, then please once again try to invoke `apt-get install [PACKAGE]` on the VM.

## Resolving this on the Vagrant VM

### The first approach:

```bash
vagrant ssh c4l20node1
vagrant@c4l20node1:~$ sudo rm /var/lib/apt/lists/* -vf
vagrant@c4l20node1:~$ sudo apt-get clean
vagrant@c4l20node1:~$ sudo apt-get update
vagrant@c4l20node1:~$ sudo apt-get upgrade
```

### The second approach:

```bash
vagrant ssh c4l20node1
vagrant@c4l20node1:~$ sudo rm /var/lib/apt/lists/* -vf
vagrant@c4l20node1:~$ sudo vim /etc/apt/apt.conf.d/01byhash
```

#### Please insert the following line into this new file:
```
Acquire::By-Hash "yes";
```

Then please run:
```bash
vagrant@c4l20node1:~$ sudo apt update
```

### The third approach:

```bash
vagrant ssh c4l20node1
vagrant@c4l20node1:~$ sudo rm /var/lib/apt/lists/* -vf
vagrant@c4l20node1:~$ sudo vim /etc/apt/apt.conf.d/99fixbadproxy
```

#### Please insert the following line into this new file:
```
Acquire::http::Pipeline-Depth 0;
Acquire::http::No-Cache true;
Acquire::BrokenProxy    true;
```

Then please run:
```bash
vagrant@c4l20node1:~$ sudo apt update
```
