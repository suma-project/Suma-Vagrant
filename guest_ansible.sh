#!/bin/bash


if [ "$1" == "bower-install" ]
then
  echo "Running bower install on guest..."
  vagrant ssh -- 'cd /vagrant/suma/analysis && /usr/local/bin/bower install'
elif [ "$1" == "npm-install" ]
then
  echo "Running npm-install on guest..."
  vagrant ssh -- 'cd /vagrant && /usr/bin/ansible-playbook /vagrant/ansible_tasks/development.yml --tags=npm-install'
elif [ "$1" == "provision-dev" ]
then
  echo "Provisioning development environment on guest (this may take awhile)..."
  vagrant ssh -- 'cd /vagrant && /usr/bin/ansible-playbook /vagrant/ansible_tasks/development.yml'
elif [ "$1" == "grunt-test" ]
then
  echo "Running grunt tests on guest..."
  vagrant ssh -- 'cd /vagrant/suma/analysis && /usr/local/bin/grunt test'
elif [ "$1" == "grunt-build" ]
then
  echo "Running grunt build on guest..."
  vagrant ssh -- 'cd /vagrant/suma/analysis && /usr/local/bin/grunt build'
elif [ "$1" == "grunt-watch" ]
then
  echo "Running grunt watch on guest..."
  echo "NOTE: this task will continue to run"
  vagrant ssh -- 'cd /vagrant/suma/analysis && /usr/local/bin/grunt watch'
elif [ "$1" == "grunt-lint" ]
then
  echo "Running grunt lint on guest..."
  vagrant ssh -- 'cd /vagrant/suma/analysis && /usr/local/bin/grunt lint'
else
  echo -e "\nUnknown or missing command, options are:\n"
  echo -e "\tbower-install - Execute bower install for analysis tools"
  echo -e "\tgrunt         - Execute grunt lint, test, and build for analysis tools"
  echo -e "\tgrunt-build   - Execute grunt build task for analysis tools"
  echo -e "\tgrunt-lint    - Execute grunt lint for analysis tools"
  echo -e "\tgrunt-test    - Execute grunt tests for analysis tools"
  echo -e "\tgrunt-watch   - Execute grunt watch for analysis tools"
  echo -e "\tnpm-install   - Execute npm install for analysis tools"
  echo -e "\tprovision-dev - Provision the development environment on the guest"
  echo -e "\n"
fi
