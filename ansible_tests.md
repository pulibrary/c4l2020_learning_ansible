## Why Test

* your roles and playbooks should be considered production code (with great power etc.,)
* check (ensure) roles/playbooks do what they actually purport to do
* check content of files (templates etc.,)
* trigger events

(ansible does all of these - but you need to make sure it ALWAYS does)

## Molecule

* Fall 2018 Red Hat adopted [Molecule and Lint](https://groups.google.com/forum/#!topic/ansible-project/ehrb6AEptzA)
* Designed to test Ansible roles
* Uses Ansible to test Ansible roles using:
  
  * Molecule
  * Testinfra
  * Docker
  * ansible-lint
  * flake8

### Setup up the following on your host machine

We will not longer need the virtual machines.

This repository uses and assumes your device has the following:

* [The extensible version manager](https://github.com/asdf-vm/asdf)
* [pipenv](https://github.com/pypa/pipenv)
* [Docker](https://www.docker.com/)


### Get Started

* We will install all the software above with:

```bash
pipenv install
pipenv shell
```

* We will initialize a role in the current directory with

```bash
molecule init role c4lexample
cd c4lexample
tree
(c4l2020_learning_ansible) c4lexample master % tree
.
├── README.md
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── molecule
│   └── default
│       ├── INSTALL.rst
│       ├── converge.yml
│       ├── molecule.yml
│       └── verify.yml
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

```

* switching into the c4lexample we see the content of the new role with the contents of an ansible role

* Inside the molecule directory in the role you will find a sub-directory default which represents the default actions we will be performing for this role

* We have the `molecule.yml` file which has the following:

```bash
(c4l2020_learning_ansible) c4l2020_learning_ansible master % cat c4lexample/molecule/default/molecule.yml
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: instance
    image: docker.io/pycontribs/centos:7
    pre_build_image: true
provisioner:
  name: ansible
verifier:
  name: ansible

```
* By default this will use a centos:7 docker image, it will depend on [ansible-galaxy](https://galaxy.ansible.com/) based roles and verified via ansible

Let's modify that to look like this

```yaml
---
scenario:
  name: default
driver:
  name: docker
platforms:
  - name: instance
    image: "pulibrary/puldocker-${MOLECULE_DISTRO:-ubuntu1804}-ansible:latest"
    privileged: true
    pre_build_image: true
provisioner:
  name: ansible
  playbooks:
    converge: playbook.yml
  log: true
dependency:
  name: galaxy
  enabled: false
lint:
  name: yamllint
  options:
    config-file: molecule/default/yaml-lint.yml
verifier:
  name: testinfra
  env:
    PYTHONWARNINGS: "ignore:.*U.*mode is deprecated:DeprecationWarning"
  lint:
    name: flake8
  options:
    # show which tests where executed in test output
    v: 1
```

* We've now disabled galaxy, we are using a [Princeton University Library](https://github.com/pulibrary/ubuntubionicimage), we are using [testinfra](https://testinfra.readthedocs.io/en/latest/) which aims to be [ServerSpec](https://serverspec.org/) for Python 