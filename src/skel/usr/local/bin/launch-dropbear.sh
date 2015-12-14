#!/usr/bin/env bash

set -e -u -o pipefail

## Set the root password as root if not set as an ENV variable
export PASSWD=${PASSWD:=root}

## Set the root password
echo "root:$PASSWD" | /usr/sbin/chpasswd

exec /usr/sbin/dropbear -E -F
