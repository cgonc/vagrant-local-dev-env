sudo rm -f /var/lib/apt/lists/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock
rm /var/cache/debconf/*.dat 

apt-get -y update
sudo dpkg --configure -a
apt-get -f install

echo "Installing htop command for performance monitoring .."
apt-get -y install htop

echo "Installing VIM editor via yum package manager .."
apt-get -y install vim

echo "Installing wget which is a utility for retrieving files using the HTTP or FTP protocols .."
apt-get -y install wget

echo "Installing locate and updatedb"
apt-get -y install mlocate
updatedb

echo "Installing net tools"
apt-get -y install net-tools

echo "Installing unzip"
apt-get -y install unzip

echo "Installing unzip"
apt-get -y install dos2unix

echo "Installing xauth"
apt-get -y install xorg
apt-get -y install openbox
apt-get -y install xauth

export DISPLAY="127.0.0.1:10.0"
echo $DISPLAY

