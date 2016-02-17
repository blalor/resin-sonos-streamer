#!/usr/bin/env bash

set -e -u -x -o pipefail

./setup_nodesource.sh
apt-get -y --no-install-recommends install \
    nodejs \
    git

useradd -r -m sonos
git clone https://git@github.com/bluestatedigital/sonos-notifier.git /opt/sonos-notifier
chown -R sonos:sonos /opt/sonos-notifier
su -l -c "cd /opt/sonos-notifier && npm install" sonos

if [ ! -e "/opt/sonos-notifier/index.js" ]; then
    echo "npm had ONE JOB to do, and fucked it up"
    exit 1
fi
