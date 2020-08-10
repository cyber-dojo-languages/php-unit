#!/bin/bash -Eeu

# Verison 10 will be released Feb 2021
readonly VERSION=9

apk add --no-cache wget
wget https://phar.phpunit.de/phpunit-${VERSION}.phar
apk del wget

chmod +x phpunit-${VERSION}.phar
mv phpunit-${VERSION}.phar /usr/local/bin/phpunit
