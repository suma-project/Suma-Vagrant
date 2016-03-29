#!/usr/bin/env bash

if [ $(dpkg-query -W -f='${Status}' ansible 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
    echo "Add APT repositories"
    export DEBIAN_FRONTEND=noninteractive
    apt-get install -qq software-properties-common || exit 1
    apt-add-repository ppa:ansible/ansible || exit 1

    apt-get update -qq

    echo "Installing Ansible"
    apt-get install -qq ansible || exit 1
    cp /vagrant/.ansible.cfg /home/vagrant/.ansible.cfg
    echo "Ansible installed"
fi

cd /vagrant/ansible_tasks
ansible-playbook demo.yml --connection=local
