# Learn to Automate with Ansible

March 8

Instructors: [James Griffin](https://github.com/jrgriffiniii), [Francis Kayiwa](https://github.com/kayiwa)

## Overview

This will be a full day workshop to introducing you to [ansible](https://ansible.com). The workshop will focus on getting attendees to use ansible. The target audience for the workshops is neophytes who are completely new automating server administration. The structure of the workshop is to remain self-driven with some guidance. This nature of this repo will be a "live" document that will be improved on by those who find bits of it missing. Pull requests are therefore most welcome.

### Software Installation etc.,

Prior to arrival for the workshop make sure you have [Vagrant](https://vagrantup.com), [VirtualBox](https://virtualbox.org). At the time of creating the document there is a bug of the latest versions of vagrant and virtualbox working together. If you are unable to follow the [steps here](https://github.com/oracle/vagrant-boxes/issues/178) please create an issue on this repository so we can create a zoom session to help you correct this. We have additional [bandwidth saving](workshop_intro.md) steps. Since hotel WiFi can be unreliable it is in everyone's best interest to follow those steps prior to arrival.

It is possible to use your UNIX-Like Operating System installation. The instructors are happy to discuss this outside of the workshop. However to allow for consistency we will be using a virtual machines to allow for consistency. It is our experience that the less hoops one has to jump through when learning the easier it is to comprehend the scope and applicability of concepts. 

#### Installing Vagrant on Ubuntu/Debian Environments

One may find that installing Vagrant using `apt install vagrant` may install a Vagrant release older than 2.2.6. If you are in this situation, please use the following to install a more recent release of Vagrant:

```bash
sudo apt -y remove vagrant
# This is the latest stable release as of 03/08/20
curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
sudo apt install ./vagrant_2.2.6_x86_64.deb
```

Then please verify the version of Vagrant with:

```
vagrant --version
```

### Code of Conduct

Attendees at this workshop are expected to abide by the [Code4lib Code of Conduct](https://2020.code4lib.org/conduct/).

In addition to the expectations above we will be applying the Hacker school [social rules](https://www.recurse.com/manual#sub-sec-social-rules) for the entirety of the workshop to foster a healthy learning environment.

### Workshop materials

The overall [agenda is here](AGENDA.md)

