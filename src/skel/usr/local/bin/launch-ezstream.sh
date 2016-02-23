#!/usr/bin/env bash

set -e -u -o pipefail

/usr/local/bin/configure-mixer.sh

lame_sample_rate=$( python -c "print('%.1f' % (float(${INPUT_SAMPLERATE})/1000))" )
lame_vbr_quality=${ICECAST_QUALITY}

## generate config
sed \
    -e "s#@@ICECAST_PROTO@@#${ICECAST_PROTO}#g" \
    -e "s#@@ICECAST_SERVER@@#${ICECAST_SERVER}#g" \
    -e "s#@@ICECAST_PORT@@#${ICECAST_PORT}#g" \
    -e "s#@@ICECAST_PASSWORD@@#${ICECAST_PASSWORD}#g" \
    -e "s#@@ICECAST_MOUNT@@#${ICECAST_MOUNT}#g" \
    -e "s#@@ICECAST_NAME@@#${ICECAST_NAME}#g" \
    -e "s#@@ICECAST_DESCRIPTION@@#${ICECAST_DESCRIPTION}#g" \
    \
    < /etc/ezstream.xml.in \
    > /etc/ezstream.xml

arecord -D hw:Device --mmap -f cd --buffer-size=192000 | \
    lame -V "${lame_vbr_quality}" -r -s "${lame_sample_rate}" --bitwidth 16 - - | \
    ezstream -c /etc/ezstream.xml
