# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_API_VERSION = "2"

Vagrant.configure(VAGRANT_API_VERSION) do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.define :"vagrant-local-dev-env" do |t|
  end

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.provider "virtualbox" do |vb|

    vb.gui = false

    # Customize the virtual box name
    vb.name = "vagrant-local-dev-env-machine"

    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']

    # Customize the amount of memory on the VM:
    vb.memory = "4096"
    vb.cpus = 4
  end

  config.vm.synced_folder '.', '/vagrant', type: "virtualbox" , disabled: true
  config.vm.synced_folder "./devenv", "/devenv", type: "rsync"

  # put maven related files
  config.vm.provision "file", source: "devenv/installations/apache-maven/settings.xml", destination: "~/settings.xml"

  # Create a private network, which allows host-only access to the machine using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # If errors occur, try running "vagrant provision" manually after "vagrant up"
  config.vm.provision :docker
  config.vm.provision :docker_compose

  config.vm.provision "run", type: "shell", privileged: false, run: "always",
    inline: <<-SHELL
      echo "=============================================="
      echo "Dos2unix Converting..."
      find /devenv -name "*.sh" | xargs dos2unix
      echo "=============================================="
  SHELL

  # custom installations for ubuntu
  config.vm.provision "shell", path: "devenv/installations/install-scripts/aptget-installations.sh"
  config.vm.provision "shell", path: "devenv/installations/install-scripts/openjdk-java-installation.sh"
  config.vm.provision "shell", path: "devenv/installations/install-scripts/mvn-installation.sh"
  config.vm.provision "shell", path: "devenv/installations/install-scripts/redis-tools-installation.sh"
   
  # start jrebel
  config.vm.network "forwarded_port", guest: 9013, host: 9013, disabled: false # mysql port
  config.vm.provision :docker_compose, rebuild: true, yml: "/devenv/docker/jrebel/docker-compose.yml", run: "always"
  
  # start redis
  config.vm.network "forwarded_port", guest: 6379, host: 6379, disabled: false  # redis master
  config.vm.provision :docker_compose, rebuild: true, yml: "/devenv/docker/redis/docker-compose.yml", run: "always"

  # start mysql
  config.vm.network "forwarded_port", guest: 3306, host: 3306, disabled: false # mysql port
  config.vm.provision :docker_compose, rebuild: true, yml: "/devenv/docker/database/mysql/docker-compose.yml", run: "always"

  # start kafka
  config.vm.network "forwarded_port", guest: 9092, host: 9092, disabled: false
  config.vm.network "forwarded_port", guest: 9000, host: 9000, disabled: false
  config.vm.provision :docker_compose, rebuild: true, yml: "/devenv/docker/kafka/docker-compose.yml", run: "always"

  #start mailhog
  config.vm.network "forwarded_port", guest: 8025, host: 8025, disabled: false
  config.vm.network "forwarded_port", guest: 1025, host: 1025, disabled: false
  config.vm.provision :docker_compose, rebuild: true, yml: "/devenv/docker/mailhog/docker-compose.yml", run: "always"
  
  # start rabbitmq
  config.vm.network "forwarded_port", guest: 5672, host: 5672, disabled: false  # rabbitmq
  config.vm.network "forwarded_port", guest: 15672, host: 15672, disabled: false  # rabbitmq-management
  config.vm.provision :docker_compose, rebuild: true, yml: "/devenv/docker/rabbitmq/docker-compose.yml", run: "always"

  config.vm.provision "run", type: "shell", privileged: false, run: "always",
    inline: <<-SHELL
      echo "=============================================="
      echo "local dev dependencies are ready !"
      docker ps --format "{{.ID}}\t{{.Names}}\t{{.Ports}}"
      echo "=============================================="
  SHELL

  if Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = false
  end

end
