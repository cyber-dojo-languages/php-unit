#!/usr/bin/env bash
set -Eeu

readonly VERSION=13

apt-get install --yes wget
wget https://phar.phpunit.de/phpunit-${VERSION}.phar
apt-get remove --yes wget 

chmod +x phpunit-${VERSION}.phar
mv phpunit-${VERSION}.phar /usr/local/bin/phpunit
