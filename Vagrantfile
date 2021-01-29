# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant LAMP Stack with Sample Data-Driven App
# v1.0.0
# Copyright 2021, Axberg & Associates LLC.

# Vagrant do loop start
Vagrant.configure("2") do |config|

  # use the ubuntu vagrant template (aka "box)
  config.vm.box = "ubuntu/bionic64"

  # don't bother to check for updates
  # config.vm.box_check_update = false

  # port forward for the web server, we'll keep everything
  # behind a firewall
  config.vm.network "forwarded_port", guest: 80, host: 80

  # other networking examples...
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  # no shared folders
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Leave the VM Config as is...keep this section in case 
  # I want to change it.
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

  # Use the Vagrant Provisioner to install the need LAMP code.
  # Simple Example:
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt update
  #   apt install -y apache2
  # SHELL

  #### EXAMPLE AUTOMATION FOR THE LAMP STACK ####
  #
  # it ain't pretty but this word.  there are ways to make
  # it more elegant, but this provides good examples

  # here is one way to use the vagrant provisioner
  # put some commands into a variable
  $script = <<-SCRIPT
  apt update
  apt install -y apache2
  apt install -y php 
  apt install -y libapache2-mod-php
  service apache2 restart
  apt install -y php-mysql
  apt install -y mariadb-server
  SCRIPT

  # then run the command in the variable
    config.vm.provision "shell", inline: $script

  # here we're going to copy a script out to the server from my laptop
  # copy a script file to the server - this script puts the app user in the db
    config.vm.provision "file", source: "users.sql", destination: "users.sql"
  
  # then run that script file so the "dbuser" is added
    config.vm.provision "shell", inline: <<-SHELL
    mysql -uroot -t < users.sql
    SHELL
  
  # grab the sample db and load sample data
  # notice I'm just grabbing the test data from git
    config.vm.provision "shell", inline: <<-SHELL
    if [ -d "test_db" ]; then rm -rf test_db fi
    git clone https://github.com/datacharmer/test_db.git
    cd test_db
    mysql -uroot -t < employees.sql
    SHELL

  # grab the sample app and deploy it to /var/www/html
  # again i'm grabbing the data from git directly
  config.vm.provision "shell", inline: <<-SHELL
  if [ -d "PHPDataDrivenSite" ]; then rm -rf PHPDataDrivenSite; fi
  git clone https://github.com/axbjos/PHPDataDrivenSite.git
  cd PHPDataDrivenSite
  cp -r *.* /var/www/html
  SHELL

end
