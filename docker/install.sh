#!/bin/bash -Eeu

apt-get install --yes wget
wget https://phar.phpunit.de/phpunit-8.5.phar
apt-get remove --yes wget

chmod +x phpunit-8.5.phar
mv phpunit-8.5.phar /usr/local/bin/phpunit
