# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# Method from numist at https://gist.github.com/numist/f34cb150e337a8b948d9
def get_local_timezone_str
  # Yes, this is actually a shell script…
  olsontz = `if [ -f /etc/timezone ]; then
    cat /etc/timezone
  elif [ -h /etc/localtime ]; then
    readlink /etc/localtime | sed "s/\\/usr\\/share\\/zoneinfo\\///"
  else
    checksum=\`md5sum /etc/localtime | cut -d' ' -f1\`
    find /usr/share/zoneinfo/ -type f -exec md5sum {} \\; | grep "^$checksum" | sed "s/.*\\/usr\\/share\\/zoneinfo\\///" | head -n 1
  fi`.chomp

  # …and it almost certainly won't work with Windows or weird *nixes
  throw "Olson time zone could not be determined" if olsontz.nil? || olsontz.empty?
  return olsontz
end

Vagrant.configure(2) do |config|

  config.vm.network "forwarded_port", guest: 80, host: 19679

  config.vm.provision :shell,
    :keep_color => true,
    :inline => "export PYTHONUNBUFFERED=1 && export ANSIBLE_FORCE_COLOR=1 && cd /vagrant && chmod u+x init.sh && ./init.sh"

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty32"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  if RUBY_PLATFORM["darwin"] || RUBY_PLATFORM["linux"]
    config.vm.synced_folder "suma/", "/vagrant/suma", create: true
  else
    config.vm.synced_folder "suma/", "/vagrant/suma", create: true, type: "smb"
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  config.vm.provider "parallels" do |vb, override|
    override.vm.box = "parallels/ubuntu-14.04-i386"
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline <<-SHELL
  #   sudo apt-get install apache2
  # SHELL

  config.vm.provision "timezone", type:"shell" do |t|
    # Host platform detection
    if RUBY_PLATFORM["darwin"]
      time_zone = get_local_timezone_str
    elsif RUBY_PLATFORM["linux"]
      time_zone=`cat /etc/timezone| tr -d '[[:space:]]'`
    else
      time_zone=`tzutil /g`
    end

    t.inline = "timedatectl set-timezone " + time_zone
  end
end
