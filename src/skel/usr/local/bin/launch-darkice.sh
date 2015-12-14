#!/usr/bin/env/bash

set -e -u -o pipefail

## diag
lsusb
cat /proc/asound/cards
arecord -l

## configure S/PDIF in
amixer -c Device set 'PCM Capture Source' "${PCM_CAPTURE_SOURCE:-IEC958 In}"

## generate config
sed \
    -e "s#@@INPUT_SAMPLERATE@@#${INPUT_SAMPLERATE}#g" \
    \
    -e "s#@@ICECAST_SERVER@@#${ICECAST_SERVER}#g" \
    -e "s#@@ICECAST_PORT@@#${ICECAST_PORT}#g" \
    -e "s#@@ICECAST_PASSWORD@@#${ICECAST_PASSWORD}#g" \
    -e "s#@@ICECAST_MOUNT@@#${ICECAST_MOUNT}#g" \
    -e "s#@@ICECAST_NAME@@#${ICECAST_NAME}#g" \
    -e "s#@@ICECAST_DESCRIPTION@@#${ICECAST_DESCRIPTION}#g" \
    \
    -e "s#@@ICECAST_BITRATE_MODE@@#${ICECAST_BITRATE_MODE}#g" \
    -e "s#@@ICECAST_QUALITY@@#${ICECAST_QUALITY}#g" \
    \
    < /etc/darkice.cfg.in \
    > /etc/darkice.cfg

exec darkice -c /etc/darkice.cfg
