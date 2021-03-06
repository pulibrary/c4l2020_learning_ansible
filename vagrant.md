# Vagrant

The subject of vagrant would fill up an entire workshop which I encourage folks to do. We are using [Vagrant](https://vagrantup.com) because it enables us to make destructive changes to our environment with little penalty. This is extremely powerful when you are motivated by mimicking your production environment. 

Vagrant is a tool that allows us to define and describe the layout and structure of a virtual machine in a single file, the `vagrantfile`. We have defined the `base-box` on line 6 of `vagranfiles/{bionic,centos}vagrantfile`.

```yaml
BOX_IMAGE = "bento/centos-7"
```
(a `base-box` is a minimal machine one can create from themselves and or pull from the vagrantcloud infrastructure). We are able to define based on the power of our host machine the number of CPUs and amount of RAM. This can be done on the lines 25 - 29

```yaml
  config.vm.provider "virtualbox" do |c4l20|
  #   # Customize the amount of memory on the VM:
  #   c4l20.memory = "1024"
  #   c4l20.cpus = 2
  end
```

Other modifications we have made worth pointing out are on lines 16 - 23.

```yaml
  (1..NODE_COUNT).each do |i|
    config.vm.define "c4l20node#{i}" do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "c4l20node#{i}"
      subconfig.vm.network :private_network, ip: "10.0.15.#{i + 10}"
      subconfig.vm.network :forwarded_port, guest: 80, host: "800#{i}"
    end
```

Here we create `NODE_COUNT` machines (line 7) and we assign them IP predefined IP addresses (line 20)

## Provisioning

It is the concept of preparing and equipping a machine to allow it to provide (new) services. Vagrant provides a number of different [provisioning modules](https://www.vagrantup.com/docs/provisioning/basic_usage.html). We are using the shell provisioning module,  which allows to upload and execute a shells script on the guest machine for the early part of the class.

Another provisioning module it provides is the Ansible Provisioner. This provisioner allows us to provision our guest machines, using an Ansible Playbook and Roles.

```bash
vagrant up
```

This will automatically configure a new virtual machine (in my case in VirtualBox), download the base-box (if it has not been downloaded already), and provision the virtual machine using the shell provisioner 

Once Vagrant has been run, the VM will be fully defined, configured, up-and-running and ready for use.  To stop the VM, we simply execute the command:

```bash
vagrant halt
```
