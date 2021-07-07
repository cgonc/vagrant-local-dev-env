# vagrant-local-dev-env
A vagrant machine which contains various technologies for local development.

The technology stack and the following ports are as follows:

- redis 6379
- mysql 3306
- kafka 9092 
- kafdrop 9000
- mailhog-ui 8025 
- mailhog 1025 
  
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