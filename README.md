# Suma-Vagrant

This is a demo project showing how Vagrant, VirtualBox, and Ansible can be used to create an easy way to demo [Suma](https://github.com/cazzerson/Suma).

## Installation

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html).
2. Clone or Download this repository.
3. From a terminal application, type `vagrant up` from the Suma-Vagrant directory and hit the `Return` key.
4. Visit [http://localhost:19679](http://localhost:19679) in your web browser.

> Parallels is also a supported provider, and can be selected
by executing `vagrant up --provider=parallels` in step 3 above.

## Configuration

To modify your Suma configuration, just edit the files in the `config` directory.

## Shutdown

To suspend your virtual machine, just type `vagrant suspend` from the `Suma-Vagrant` directory. To shut the machine down, type `vagrant halt`. You can start it back up again with `vagrant up`.

## Admin Tools

The Suma admin tools can be found at [http://localhost:19679/sumaserver/admin](http://localhost:19679/sumaserver/admin). The default admin username is "sumaadmin" and admin password is "sumaadmin".

## NOTICE

This project is a demo project only and is not intended for production use at this time. *Please use this only for testing or development deployments*.
