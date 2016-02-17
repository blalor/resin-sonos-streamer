#!/usr/bin/env bash

set -e -u -o pipefail

chroot \
    --userspec=nobody:nogroup \
    / \
    node /usr/lib/node_modules/bsd-sonos-notifier/index.js \
    "${HUBOT_URL}" \
    "${ICECAST_NAME}"
