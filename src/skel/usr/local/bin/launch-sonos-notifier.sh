#!/usr/bin/env bash

set -e -u -o pipefail

exec node /opt/sonos-notifier/index.js "${HUBOT_URL}" "${ICECAST_NAME}"
