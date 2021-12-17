# Suma-Vagrant

This is a project showing how Vagrant, VirtualBox, and Ansible can be used to create a demo of [Suma](https://github.com/suma-project/Suma). This is also the recommended Suma development environment.

## Installation

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html).
2. Clone or Download this repository.
3. From a terminal application, type `vagrant up` from the Suma-Vagrant directory and hit the `Return` key. Note: If you are on OSX, you may need to enter your administrator password. This is so the timezone of the virtual machine (guest) may be configured to match that of the host.
4. Visit [http://localhost:19679](http://localhost:19679) in your web browser.

## Virtual Machine Management

To suspend your virtual machine, type `vagrant suspend` from the `Suma-Vagrant` directory.

To shut the machine down, type `vagrant halt`.

To start it back up again, type `vagrant up`.

## Admin Tools

The Suma admin tools can be found at [http://localhost:19679/sumaserver/admin](http://localhost:19679/sumaserver/admin). The default admin username is "sumaadmin" and admin password is "sumaadmin".

## PHP Version

Suma-Vagrant installs Suma in a PHP 7.x environment. If you need to experiment with an older version under PHP 5.x, please use one of the 5.x branches.

## Using Suma-Vagrant as a development environment for Suma

This project includes a bash script "guest_ansible.sh" for executing development related commands on the Vagrant managed virtual machine. This allows the developer to work in the Suma repository on the host environment using their own configured text editor. For example, to run the test suite, from a terminal application, type `./guest_ansible.sh grunt-test` and hit the `Return` key. This script has additional subcommands that are listed below:

  * bower-clean    - Clean bower_components directory
  * bower-install  - Execute bower install for analysis tools
  * grunt          - Execute grunt lint, test, and build for analysis tools
  * grunt-build    - Execute grunt build task for analysis tools
  * grunt-lint     - Execute grunt lint for analysis tools
  * grunt-test     - Execute grunt tests for analysis tools
  * grunt-watch    - Execute grunt watch for analysis tools
  * npm-clean      - Clean node_modules directory
  * npm-install    - Execute npm install for analysis tools

## Upgrading external Ansible roles

To upgrade the external Ansible roles used for installing PHP, MySQL, Apache, and RVM, run `ansible-galaxy install -r ansible/requirements.yml -p ansible/roles/ --force`.

## NOTICE

This project is not intended for production use at this time. *Please use this only for testing or development deployments*.
