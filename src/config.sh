#!/usr/bin/env bash

set -e -u -o pipefail

cd "$( dirname "${0}" )"

./rebuild-and-install-darkice.sh

apt-get -y --no-install-recommends install \
    dropbear \
    usbutils \
    alsa-utils \
    supervisor

## copy over skel dir
(cd skel ; find . -type f | tar -c -f - -T -) | tar -xf - -C /

## cleanup
cd /
apt-get clean
rm -rf /tmp/src
