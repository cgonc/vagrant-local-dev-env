# https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html adresinden java'yı indiriniz.
# /vagrant/sde/installations/install-scripts altına bırakınız.
# daha sonra bu dosyayı silebilirsiniz.

rm -rf /opt/jdk
update-alternatives --remove-all java
update-alternatives --remove-all javac
mkdir /opt/jdk
tar -zxf jdk-8u202-linux-x64.tar.gz -C /opt/jdk
update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_202/bin/java 10001
update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_202/bin/javac 10001
update-alternatives --auto java
update-alternatives --display java
update-alternatives --auto javac
update-alternatives --display javac
java -version
javac -version

echo "************************************************************************************"
echo "*** which java: $(which java)"
echo "*** ls -l /usr/bin/java: $(ls -l /usr/bin/java)"
echo "*** ls -l /etc/alternatives/java: $(ls -l /etc/alternatives/java)"
echo "************************************************************************************"
