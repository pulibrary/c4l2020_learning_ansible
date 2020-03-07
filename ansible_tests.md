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

* switching into the c4lexample we see the contents of a new ansible role