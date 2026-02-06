#!/bin/bash -Eeu

readonly VERSION=13

apk add --no-cache wget
wget https://phar.phpunit.de/phpunit-${VERSION}.phar
apk del wget

chmod +x phpunit-${VERSION}.phar
mv phpunit-${VERSION}.phar /usr/local/bin/phpunit
