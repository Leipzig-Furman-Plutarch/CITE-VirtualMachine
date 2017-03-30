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




# JDK bundle
#apt-get install -y openjdk-7-jdk
apt-get -y -q update
apt-get -y -q upgrade
apt-get -y -q install software-properties-common htop
add-apt-repository ppa:webupd8team/java
apt-get -y -q update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y -q install oracle-java8-installer
apt-get -y -q install oracle-java7-installer
update-java-alternatives -s java-8-oracle
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
sudo curl http://mirror.olnevhost.net/pub/apache/jena/binaries/apache-jena-3.2.0.tar.gz -o apache-jena-3.1.0.tar.gz
sudo tar zxfv apache-jena-3.2.0.tar.gz
sudo rm apache-jena-3.2.0.tar.gz
sudo ln -s apache-jena-3.2.0 jena

echo "-------------------------------------"
echo " Downloading Fuseki"
echo "-------------------------------------"

sudo curl http://mirror.olnevhost.net/pub/apache/jena/binaries/apache-jena-fuseki-2.5.0.tar.gz -o apache-jena-fuseki-2.4.0.tar.gz
sudo tar zxfv apache-jena-fuseki-2.5.0.tar.gz
sudo rm apache-jena-fuseki-2.5.0.tar.gz

# Tomcat
sudo apt-get install tomcat7

#########################################################
### Configure system and user settings        ###########
#########################################################


# Set up vagrant user account:
cp /vagrant/system/dotprofile /home/vagrant/.profile
echo "source /vagrant/system/dotprofile" >> /home/vagrant/.bashrc
chown vagrant:vagrant /home/vagrant/.profile
chown vagrant:vagrant /home/vagrant/.bashrc

#########################################################
### Clone/Pull/Update Some Repos  ###########
#########################################################

# cd /vagrant
# git clone https://github.com/cite-architecture/citemgr.git
# git clone https://github.com/cite-architecture/cs2.git
# git clone https://github.com/cite-architecture/cite_test_ttl.git
# git clone https://github.com/Eumaeus/cts-demo-corpus.git
# git clone https://github.com/cite-architecture/cite-archive-manager

#########################################################
### Set Up CITE Manager  ###########
#########################################################

# cd /vagrant/citemgr
# git pull
# cp ../scripts/cts-test.gradle .
# cp ../scripts/cts-demo.gradle .
#gradle clean

#########################################################
### Set Up CITE Servlet 2  ###########
#########################################################

# And let's get Apache2, so we can do some URL rewriting for CTS and CITE
apt-get install -y apache2
a2enmod proxy
a2enmod proxy_http
a2enmod rewrite
service apache2 restart
