#!/usr/bin/env bash

set -e -u -o pipefail

cd "$( dirname "${0}" )"

apt-get update

apt-get -y --no-install-recommends install \
    curl \
    dropbear \
    usbutils \
    alsa-utils \
    build-essential \
    supervisor

# ./rebuild-and-install-darkice.sh
./build-and-install-ezstream.sh
./build-and-install-sonos-notifier.sh

## copy over skel dir
(cd skel ; find . -type f | tar -c -f - -T -) | tar -xf - -C /

## cleanup
cd /
apt-get clean
rm -rf /tmp/src
