#!/usr/bin/env bash

set -e -u -x -o pipefail

apt-get -y --no-install-recommends install \
    libshout3-dev \
    libxml2-dev \
    lame \
    curl

## set up build directory
builddir=$( mktemp -d )
pushd "${builddir}" >/dev/null

curl -sfSLO http://downloads.xiph.org/releases/ezstream/ezstream-0.6.0.tar.gz
tar -xzf ezstream-0.6.0.tar.gz
pushd ezstream-0.6.0

./configure 
make install

popd

## clean up
popd
rm -rf "${builddir}"
