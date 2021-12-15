# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# Verify and install required plugins
required_plugins = %s(vagrant-vbguest vagrant-sshfs)
# TODO: Should we auto-update these?
if ENV['VAGRANT_PLUGINS_UPDATED']=='true'
   alreadyUpdated = 'true'
end

if alreadyUpdated != 'true' && (ARGV[0] == "up" || ARGV[0] == "provision")
  system "vagrant plugin install #{required_plugins}"
  system "vagrant plugin update #{required_plugins}"
  ENV['VAGRANT_PLUGINS_UPDATED'] = 'true'

  # Restart vagrant after plugin updates
  exec "vagrant #{ARGV.join(' ')}"
end

# Method from numist at https://gist.github.com/numist/f34cb150e337a8b948d9
# Slight edit to the elif that should handle when localtime is linked
# to an alternate location
def get_local_timezone_str
  olsontz = `if [ -f /etc/timezone ]; then
    cat /etc/timezone
  elif [ -h /etc/localtime ]; then
    readlink /etc/localtime | sed "s/^.*zoneinfo\\///"
  else
    checksum=\`/sbin/md5 -r /etc/localtime | cut -d' ' -f1\`
    find /usr/share/zoneinfo/ -type f -exec /sbin/md5 -r {} \\; | grep "^$checksum" | sed "s/.*\\/usr\\/share\\/zoneinfo\\///" | head -n 1
  fi`.chomp

  throw "Olson time zone could not be determined" if olsontz.nil? || olsontz.empty?
  return olsontz
end

Vagrant.configure(2) do |config|

  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.box = "geerlingguy/centos7"
  config.vm.hostname = "suma-vagrant"
  config.vm.synced_folder ".", "/vagrant", type: "sshfs"
  config.ssh.forward_agent = true

  # Create a forwarded port mapping
  config.vm.network "forwarded_port", guest: 80, host: 19679
  config.vm.network "forwarded_port", guest: 3306, host: 3306

  # install git before running ansible provisioner
  config.vm.provision "shell", inline: "yum -y install git"

  # Ansible provisioning
  config.vm.provision "ansible_local" do |ansible|
    ansible.provisioning_path = '/vagrant/ansible'
    ansible.playbook = 'demo.yml'
    ansible.inventory_path = 'inventories/development.ini'
    ansible.limit = 'all'
  end

  # Timezone provisioning
  config.vm.provision "timezone", type:"shell" do |t|
    # Host platform detection
    if RUBY_PLATFORM["darwin"]
      begin
        time_zone = get_local_timezone_str
      rescue
        time_zone = "UTC"
      end
    elsif RUBY_PLATFORM["linux"]
      time_zone=`cat /etc/timezone| tr -d '[[:space:]]'`
    else
      time_zone=`tzutil /g`
    end

    t.inline = "timedatectl set-timezone " + time_zone
  end
end
