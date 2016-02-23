#!/usr/bin/env bash

set -e -u -o pipefail

## diag
lsusb
cat /proc/asound/cards
arecord -l

## configure the mixer
amixer -c Device set 'PCM Capture Source' "${PCM_CAPTURE_SOURCE:-IEC958 In}"

## defaults to something quite high which is distorted as fuck
amixer -c Device set 'Line,0,Capture' 0
