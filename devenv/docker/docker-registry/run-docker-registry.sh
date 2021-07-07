#!/bin/sh


# If anybody deletes htpasswd file
# generate with the command below in docker host.
# mkdir registry-auth
# docker run --entrypoint htpasswd registry:2 -Bbn ecssuser ZteNetas2020 > /vagrant/softwaredevelopmentkit/docker/docker-registry/registry-auth/htpasswd

echo "creating docker registry htpasswd.."

cd /vagrant/softwaredevelopmentkit/docker/docker-registry

echo "docker registry htpasswd is ready.."
echo "starting registry with docker-compose -d"

# start docker registry
docker-compose up -d

echo "wait 2 seconds from registry"
sleep 2s

echo "try to login 192.168.33.11:5000"

# login to docker registry
yes | docker login 192.168.33.11:5000 --username=ecssuser --password=ZteNetas2020

# vagrant icerisinde eger "http: server gave HTTP response to HTTPS client" hatası alırsanız bunun icin kktccodehandbook'taki insecure-registries başlığı altındaki islemleri yapiniz.
