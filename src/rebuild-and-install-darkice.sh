#!/usr/bin/env bash

set -e -u -x -o pipefail

## https://stmllr.net/blog/live-mp3-streaming-from-audio-in-with-darkice-and-icecast2-on-raspberry-pi/

## configure apt to download sources
sed -e 's#^deb#deb-src#' /etc/apt/sources.list > /etc/apt/sources.list.d/source.list
apt-get update

## install darkice build dependencies
apt-get -y build-dep darkice
apt-get -y --no-install-recommends install \
    fakeroot \
    devscripts \
    libmp3lame-dev \
    libsamplerate0-dev

## set up build directory
builddir=$( mktemp -d )
pushd "${builddir}" >/dev/null

## retrieve darkice source and extract it
apt-get source darkice
dpkg-source -x darkice_1.0-1.dsc
pushd darkice-1.0

## set build flags to add mp3 (lame) support
sed \
    -i \
    -e "/\tdh_auto_configure --/c\\\tdh_auto_configure -- --prefix=/usr --sysconfdir=/usr/share/doc/darkice/examples --with-alsa-prefix=/usr/lib/arm-linux-gnueabihf/ --with-samplerate-prefix=/usr/lib/arm-linux-gnueabihf/ --with-lame-prefix=/usr/lib/arm-linux-gnueabihf/ CFLAGS='-march=armv6 -mfpu=vfp -mfloat-abi=hard'" \
    debian/rules

## bump the version
cat <<EOF > debian/changelog.new
darkice (1.0-999~mp3+1) UNRELEASED; urgency=low

  * New build with mp3 support

 --  <pi@raspberrypi>  Sat, 11 Aug 2012 13:35:06 +0000

EOF

cat debian/changelog >> debian/changelog.new
mv -f debian/changelog.new debian/changelog

## build the binary
dpkg-buildpackage -rfakeroot -uc -b
popd

## install the new binary
dpkg -i darkice_1.0-999~mp3+1_armhf.deb

## clean up
popd
rm -rf "${builddir}"
