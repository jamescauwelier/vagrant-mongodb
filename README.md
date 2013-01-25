vagrant-mongodb
===============

sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ondrej/php5
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install php5
sudo apt-get install php5-dev
sudo apt-get install php-pear
sudo apt-get install re2c
sudo apt-get install make

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
sudo apt-get install mongodb-10gen
sudo pecl install mongo

sudo vi /etc/php5/conf.d/mongo.ini
 >>> extension=mongo.so