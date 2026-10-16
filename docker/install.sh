#!/usr/bin/env bash
set -Eeu

# Appends one test framework to the test_frameworks list the base image
# wrote in /versions.json, keeping any entry an earlier image added. Stops
# the build if the list is not found, rather than record nothing.
add_test_framework()
{
  local -r name="${1}"
  local -r version="${2}"
  local -r entry="{\"name\": \"${name}\", \"version\": \"${version}\"}"
  if grep -q '"test_frameworks": \[\]' /versions.json; then
    sed -i "s|\"test_frameworks\": \[\]|\"test_frameworks\": [${entry}]|" /versions.json
  else
    sed -i "/\"test_frameworks\": \[/s|}\]|}, ${entry}]|" /versions.json
  fi
  if ! grep -q -F "${entry}" /versions.json; then
    echo "Could not add ${name} to /versions.json" >&2
    cat /versions.json >&2
    exit 1
  fi
}

# The unversioned phar is always PHPUnit's newest release.
apt-get install --yes wget
wget https://phar.phpunit.de/phpunit.phar
apt-get remove --yes wget

chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit

# PHPUnit is asked for its version, so the record is the one a kata runs.
readonly PHPUNIT_VERSION=$(phpunit --version | sed -n 's/^PHPUnit \([0-9.]*\) .*$/\1/p')
if [ -z "${PHPUNIT_VERSION}" ]; then
  echo 'Could not read the PHPUnit version' >&2
  phpunit --version >&2
  exit 1
fi
add_test_framework PHPUnit "${PHPUNIT_VERSION}"
cat /versions.json
