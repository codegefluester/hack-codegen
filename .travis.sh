#!/bin/sh
set -ex
apt update -y
DEBIAN_FRONTEND=noninteractive apt install -y php-cli zip unzip
hhvm --version
php --version

(
  cd $(mktemp -d)
  curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
)
composer install

hh_client

hhvm vendor/bin/hacktest tests/
if !(hhvm --version | grep -q -- -dev); then
  hhvm vendor/bin/hhast-lint
fi

hhvm examples/dorm/codegen.php examples/dorm/demo/DormUserSchema.php
if ! git diff --quiet; then
  echo "Demo codegen not up to date."
  exit 1
fi
