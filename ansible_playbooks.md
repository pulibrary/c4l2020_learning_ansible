## Ansible Playbooks

Playbooks are a different way to use ansible from the ad-hoc examples we've looked at thus far. One of the reasons we labored through the manual steps of installing and configuring the software is because Ansible assumes you know what you are doing. So if your task reconfigures the nginx server, Ansible will not know that those tasks require the webserver to be restarted as a way of example. Thinking of Ansible playbooks as a an ordered series of tasks I want *played* on a remote host works for me. For those who have played American football the playbook reference is easier to get.  They are written in YAML and can be used to just about anything on a remote host.

### Ansible playbooks consist of

* Hosts
* Tasks
* Handlers (not always)

For our purposes the [hosts](ansible/inventory) are the machines we plan to manage. 


#### Simple Playbook Exercise

* Create a playbook inside the ansible directory called `hello_world.yml` with the following content.

```yaml
---
- hosts: all
  tasks:
  - name: Hello world
    debug:
      msg: Hello, world
```

Then log into the controller machine and switch into the ansible directory and run the playbook with 

```bash
ansible-playbook hello_world.yml
```

#### Tasks

An ansible task describes a state which shall be obtained on the machine. (I know!). That terrible sentence is better than using the word `idempotent` which is a good thing to remember about tasks. 

Tasks:
* do not mean machine X "go thou and do X" but rather,
* "machine X go and make sure X is done"
* Described in YAML, in a list. 
  * Each list item is a separate item executed sequentially
  * If any task fails, execution ends
* Tasks always have a name and a YAML dictionary name for the module the task is using

```yaml
---
- name: make sure that vagrant user exists
  user:
    home: /home/vagrant
    name: vagrant
    shell: /bin/bash
    state: present
    system: false
```

* Tasks are sometimes conditional, or only run in some cases.
  * ... only if the host is bionic or xenial
  * ... only if postgresql version 10 was installed
* The *when* key takes an expression and skips the task if the expression is false

#### Simple Task Exercise

```yaml
---
- hosts: all
  tasks:
  - name: Hello world
    debug:
      msg: Hello, world

  - name: install apache2
    apt:
      name: apache2
      state: present
      update_cache: true
    when: ansible_os_family == "Debian"

   - name: install httpd
    yum:
      name: httpd
      state: present
      update_cache: true
    when: ansible_os_family == "Redhat"
```

append this to the `hello_world.yml` file you created earlier and run it

#### More Tasks

* Tasks should be idempotent whenever possible (stay on for the optional section on writing tests using molecule)
* `Idempotency` means that running the task ensures the machine is in a certain state


### Playbook Exercise

Create a new playbook called `simple_playbook.yml` in the ansible directory

* install PostgreSQL 12 on c4l20node1
* install java-11-openjdk on c4l20node1
* install php and nginx on c4l20node2 and c4l20node3

Use the [Centos](manual_centos_setup.md) and [Ubuntu](manual_ubuntu_setup.md). You will need to use the [apt](https://docs.ansible.com/ansible/latest/modules/apt_module.html) and/or the [yum](https://docs.ansible.com/ansible/latest/modules/yum_module.html)
For those with previous ansible experience make the simple playbook possible to use in either Ubuntu or Centos. 

