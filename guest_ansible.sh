#!/usr/bin/env bash

if [ "$1" == "bower-install" ]
then
  echo "Running bower install on guest..."
  vagrant ssh -- 'cd /vagrant/suma/analysis && /usr/local/bin/bower install'
elif [ "$1" == "bower-clean" ]
then
  echo "Running bower-clean on guest..."
  vagrant ssh -- 'cd /vagrant/suma/analysis/src && rm -r bower_components'
elif [ "$1" == "npm-install" ]
then
  echo "Running npm-install on guest..."
  vagrant ssh -- 'cd /vagrant/ansible && /usr/bin/ansible-playbook /vagrant/ansible/development.yml --tags=npm-install --inventory=/vagrant/ansible/inventories/development.ini'
elif [ "$1" == "npm-clean" ]
then
  echo "Running npm-clean on guest..."
  vagrant ssh -- 'cd /vagrant/suma/analysis && rm -r node_modules'
elif [ "$1" == "grunt" ]
then
  echo "Running default grunt tasks on guest..."
  vagrant ssh -- 'source /home/vagrant/.bash_profile; cd /vagrant/suma/analysis && /usr/local/bin/grunt'
elif [ "$1" == "grunt-test" ]
then
  echo "Running grunt tests on guest..."
  vagrant ssh -- 'source /home/vagrant/.bash_profile; cd /vagrant/suma/analysis && /usr/bin/grunt test'
elif [ "$1" == "grunt-build" ]
then
  echo "Running grunt build on guest..."
  vagrant ssh -- 'source /home/vagrant/.bash_profile; cd /vagrant/suma/analysis && /usr/local/bin/grunt build'
elif [ "$1" == "grunt-watch" ]
then
  echo "Running grunt watch on guest..."
  echo "NOTE: this task will continue to run"
  vagrant ssh -- 'source /home/vagrant/.bash_profile; cd /vagrant/suma/analysis && /usr/local/bin/grunt watch'
elif [ "$1" == "grunt-lint" ]
then
  echo "Running grunt lint on guest..."
  vagrant ssh -- 'cd /vagrant/suma/analysis && /usr/local/bin/grunt lint'
else
  echo -e "\nUnknown or missing command, options are:\n"
  echo -e "\tbower-clean    - Clean bower_components directory"
  echo -e "\tbower-install  - Execute bower install for analysis tools"
  echo -e "\tgrunt          - Execute grunt lint, test, and build for analysis tools"
  echo -e "\tgrunt-build    - Execute grunt build task for analysis tools"
  echo -e "\tgrunt-lint     - Execute grunt lint for analysis tools"
  echo -e "\tgrunt-test     - Execute grunt tests for analysis tools"
  echo -e "\tgrunt-watch    - Execute grunt watch for analysis tools"
  echo -e "\tnpm-clean      - Clean node_modules directory"
  echo -e "\tnpm-install    - Execute npm install for analysis tools"
  echo -e "\n"
fi
