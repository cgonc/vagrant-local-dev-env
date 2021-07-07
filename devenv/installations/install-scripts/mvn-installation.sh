#!/bin/sh

echo "Installing mvn 3 .."

sudo apt-get purge -y maven
if ! [ -e apache-maven-3.6.3-bin.tar.gz ]; then (curl -OL https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz); fi
sudo tar -zxf apache-maven-3.6.3-bin.tar.gz -C /usr/local/
sudo ln -s /usr/local/apache-maven-3.6.3/bin/mvn /usr/bin/mvn
yes | cp -rf /home/vagrant/settings.xml /usr/local/apache-maven-3.6.3/conf/settings.xml
echo "************************************************************************************"
echo "Maven is on version `mvn -v`"
echo "************************************************************************************"
