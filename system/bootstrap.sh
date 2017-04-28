#!/usr/bin/env bash


#
# Repository for an early-21st-century version of gradle:
add-apt-repository ppa:cwchien/gradle
apt-get update

#########################################################
### Install packages required for HMT editing ###########
#########################################################

# Clean up any catastrophic reformatting that
# 'git clone' could introduce on a Windows box:
apt-get install -y dos2unix
/usr/bin/dos2unix /vagrant/system/*sh
/usr/bin/dos2unix /vagrant/system/dotprofile
/usr/bin/dos2unix /vagrant/scripts/*sh

# and add bomstrip utils in case XML Copy Editor
# or evil Windows software tries to insert a BOM
# in your editorial work:
apt-get install -y bomstrip

# Curl
apt-get install -y curl

# version control
apt-get install -y git

# a better editor
apt-get remove -y vim-tiny
apt-get install -y vim

# an easy editor
apt-get install -y nano

# gzip, if it isn't already installed
apt-get install -y gzip

# JDK bundle
#apt-get install -y openjdk-7-jdk
apt-get -y -q update
apt-get -y -q upgrade
apt-get -y -q install software-properties-common htop
#add-apt-repository ppa:webupd8team/java
apt-get -y -q update
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y upgrade
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer
echo "Setting environment variables for Java 8.."
sudo apt-get install -y oracle-java8-set-default
apt-get -y install groovy
apt-get -y install gradle

# install SBT
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt

# Jena and Jena-Fuseki

echo "-------------------------------------"
echo " Downloading Apache Jena "
echo "-------------------------------------"

cd /usr/bin
sudo curl http://mirror.olnevhost.net/pub/apache/jena/binaries/apache-jena-3.2.0.tar.gz -o apache-jena-3.2.0.tar.gz
sudo tar zxfv apache-jena-3.2.0.tar.gz
sudo rm apache-jena-3.2.0.tar.gz
sudo ln -s apache-jena-3.2.0 jena
cd /vagrant/Data
curl http://central.maven.org/maven2/org/apache/jena/jena-fuseki-war/2.5.0/jena-fuseki-war-2.5.0.war -o fuseki.war

echo "-------------------------------------"
echo " Downloading Tomcat"
echo "-------------------------------------"

# Tomcat
sudo apt-get install -y tomcat7
sudo cp /vagrant/system/tomcat7_default /etc/default/tomcat7

#########################################################
### Configure system and user settings        ###########
#########################################################

# Set up vagrant user account:
cp /vagrant/system/dotprofile /home/vagrant/.profile
cp /vagrant/system/vimrc /home/vagrant/.vimrc
echo "source /vagrant/system/dotprofile" >> /home/vagrant/.bashrc
chown vagrant:vagrant /home/vagrant/.profile
chown vagrant:vagrant /home/vagrant/.bashrc
source /home/vagrant/.profile

#########################################################
### Reassemble the massive TTL datafile,
### (split up for GitHub)
### And build database
#########################################################

mkdir -p /etc/fuseki
chmod 777 /etc/fuseki
cd /etc/fuseki
mkdir -p databases/cite
cp /vagrant/system/config.ttl .
cd /vagrant/Data/parts-all-ttl/
gunzip all-ttl-part1.gz
gunzip all-ttl-part2.gz
#rm all-ttl-parts1.tgz
#rm all-ttl-parts2.tgz
cat all-ttl-part1 all-ttl-part2 > ../all.ttl
cd /usr/bin/jena/bin
./tdbloader2 --loc /etc/fuseki/databases/cite/ /vagrant/Data/all.ttl


#########################################################
### Clone/Pull/Update Some Repos  ###########
#########################################################

cd /vagrant
git clone https://github.com/Eumaeus/cts-demo-corpus.git
git clone https://github.com/cite-architecture/cite-archive-manager
git clone https://github.com/cite-architecture/CITE-App.git
git clone https://github.com/Eumaeus/croala-twiddle.git
git clone https://github.com/cite-architecture/citedx.git
git clone https://github.com/cite-architecture/cex-maker.git

#########################################################
### Copy CITE Manager Configs  ###########
#########################################################

cd /vagrant/cite-archive-manager
cp /vagrant/scripts/mgr_scripts/all-conf.gradle .
cp /vagrant/scripts/mgr_scripts/all-mini-conf.gradle .
cp /vagrant/scripts/mgr_scripts/all-smaller-conf.gradle .
cp all-mini-conf.gradle conf.gradle
gradle clean



#########################################################
### Set Up CITE Servlet 2  ###########
#########################################################

# And let's get Apache2, so we can do some URL rewriting for CTS and CITE
apt-get install -y apache2
a2enmod proxy
a2enmod proxy_http
a2enmod rewrite
service apache2 restart
sudo cp /vagrant/system/apache2-cite-proxy.conf /etc/apache2/sites-available/cite.conf
sudo a2ensite cite.conf
sudo apachectl restart
# Move sample links into place
sudo cp /vagrant/system/Links.html /var/www/
sudo mv /var/www/Links.html /var/www/index.html
# Move the single-page CITE Environment into place
sudo cp /vagrant/CITE-App/downloads/cite-1.2.1.html /var/www/
sudo mv /var/www/cite-1.2.1.html /var/www/cite.html

# And let's move the cs2 and Fuseki servlets into place…
cd /var/lib/tomcat7/webapps
sudo cp /vagrant/Data/cs2.war .
sudo cp /vagrant/Data/fuseki.war .
sudo service tomcat7 stop
# shiro.ini controls access to Fuseki; this one gives everyone access to the management tools
cp /vagrant/system/shiro.ini /etc/fuseki/shiro.ini
chmod -R 777 /etc/fuseki
sudo service tomcat7 start

# Final clean up
sudo apt-get -y autoremove

echo "-----------------------------------"
echo "The virtual machine is ready."
echo ""
echo "Do 'vagrant ssh' to log into it. Or…"
echo "… just visit http:192.168.22.10/cs2 to work with the CITE Servlet."
echo ""
echo "Access the page of sample links via your host computer at http://192.168.33.10/"
echo "Access the single-page CITE App via your host computer at http://192.168.33.10/cite.html"
echo "-----------------------------------"
