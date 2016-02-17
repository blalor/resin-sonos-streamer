#!/usr/bin/env bash

set -e -u -x -o pipefail

./setup_nodesource.sh
apt-get -y --no-install-recommends install \
    nodejs \
    git

npm install -g https://github.com/bluestatedigital/sonos-notifier/tarball/master
