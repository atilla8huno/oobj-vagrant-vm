#!/bin/bash

echo "- Starting provisioning..."

# I'm behind a fucking proxy...
. /vagrant/scripts/setproxy.sh

# The bitch ass application directory
APPL_DIR="/home/vagrant/appl"

# Add some motherfucking repos:
apt-add-repository -y ppa:webupd8team/java
#apt-add-repository -y ppa:git-core/ppa
#apt-add-repository -y ppa:nginx/stable
#apt-add-repository -y ppa:chris-lea/node.js
#apt-add-repository -y ppa:chris-lea/redis-server

# If you need diferent Postgresql shit than the system default:
# echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list
# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Update the system
apt-get -qy update
apt-get -qy dist-upgrade

# Install needed junk
apt-get -qy install unzip subversion postgresql

# Install the shit faced Java
# Accept the fucking license first
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
# Then proceed to the fucking installation
apt-get -qy install oracle-java7-installer oracle-java7-set-default

# Create the of application directory:
su vagrant -c "mkdir -p $APPL_DIR"

# Get inside the fucking shared folder
cd /vagrant

# Install the cockamster Tomcat
# =============================

# Download only if the shit not exists and extract to application directory
# So don't fucking download again if it's not damn needed!
# Keep downloaded shit in the fucking dist directory!
cd dist
wget -nc http://mirror.nbtelecom.com.br/apache/tomcat/tomcat-7/v7.0.57/bin/apache-tomcat-7.0.57.tar.gz
su vagrant -c "tar xzf apache-tomcat-7.0.57.tar.gz -C /home/vagrant/appl"
cd ..

# Creates a simbolic fucking link to make it version independent.
# So new versions will not impact in the update.rc file which uses 'tomcat' only.
su vagrant -c "ln -s /home/vagrant/appl/apache-tomcat-7.0.57 /home/vagrant/appl/tomcat"

# Set to start on fucking boot:
cp config/tomcat /etc/init.d
chmod a+x /etc/init.d/tomcat
update-rc.d tomcat defaults

# Start that shit now!
service tomcat start

echo '- Done.'
