## Why Test

* your roles and playbooks should be considered production code (with great power etc.,)
* check (ensure) roles/playbooks what they do
* check content of files
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

This repository uses and assumes:

* [The extensible version manager](https://github.com/asdf-vm/asdf)
* [pipenv](https://github.com/pypa/pipenv)
* [Docker](https://www.docker.com/)