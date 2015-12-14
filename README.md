# The Office Culture-Builder™

Our offices have Sonos systems and music is a huge part of our company culture.  But not everyone's in the office every day.  And wouldn't it be cool if Boston could listen in on London's Clash playlist?  Unfortunately Sonos doesn't provide this functionality.  But with a Sonos Connect and a Raspberry Pi you can roll our own streaming Sonos radio station for others to enjoy!

This repository contains the source for a Docker image that is deployed to a [Raspberry Pi](https://www.raspberrypi.org) via the [resin.io](https://resin.io) platform.  Inside the image, [DarkIce](http://darkice.org) records the audio from an external USB sound card and streams it to an external [Icecast](http://www.icecast.org) server.  To listen to the stream, all you have to do is connect to the Icecast endpoint with your favorite client, such as iTunes or another Sonos system!

All configuration is performed via [environment variables](http://docs.resin.io/#/pages/management/env-vars.md), so multiple devices can be part of a single resin.io application and Icecast server, and anyone can use this image to set up their own Sonos streamer.

## Not complete, yet!

This is still a work in progress.  The streaming with DarkIce is working, but the integration with Sonos to retrieve song metadata is a proven concept but as yet unimplemented in this repository.

## Bill of Materials

Gather these components for every office.

* [Sonos Connect](http://www.sonos.com/shop/connect) ($350)
* [Raspberry Pi](https://www.amazon.com/gp/product/B00T2U7R7I/ref=od_aui_detailpages00?ie=UTF8&psc=1) ($38)
* [USB sound card](https://www.amazon.com/gp/product/B00Q4WQ7XW/ref=od_aui_detailpages00?ie=UTF8&psc=1) ($15); this one has S/PDIF and line outputs
* Other rπ bits and bobs: [power supply](https://www.amazon.com/gp/product/B00MARDJZ4/ref=od_aui_detailpages00?ie=UTF8&psc=1), [case](https://www.amazon.com/gp/product/B00ONOKPHC/ref=od_aui_detailpages00?ie=UTF8&psc=1), [16GB MicroSD card](https://www.amazon.com/gp/product/B00DYQYLQQ/ref=od_aui_detailpages00?ie=UTF8&psc=1), [Toslink cable](https://www.amazon.com/AmazonBasics-Digital-Optical-Audio-Toslink/dp/B00NH11H38/ref=sr_1_3?ie=UTF8&qid=1450107959&sr=8-3&keywords=toslink+cable)

## Hookup guide

This should be pretty straightforward.

0. download the device- and application-specific resin.io image, write it to the SD card, and plug it into the Pi
1. connect the USB sound card to the Pi
2. connect the Pi to the same physical network as your Sonos system (I'm using Ethernet, but a supported WiFi dongle should work, too)
3. connect the Toslink cable from your Sonos Connect to the S/PDIF input on the USB sound card
4. power it up
5. listen!

Ok, there are probably some missing steps, since I don't actually have a Sonos Connect to work with, yet, but in theory…

## Configuration

* `PCM_CAPTURE_SOURCE` - the PCM source for the sound card; defaults to `IEC958 In`.  The other suitable option may be `Line`.  Consult `amixer` for details.
* `INPUT_SAMPLERATE` - Sample rate; defaults to `48000`, but `44100` may be appropriate.  Need to verify this, still.
* `ICECAST_SERVER`, `ICECAST_PORT` - Address and port of your Icecast server.
* `ICECAST_PASSWORD` - Password for the Icecast server (or mount point).
* `ICECAST_MOUNT` - Icecast mount point name; no leading `/` (eg. `boston`).
* `ICECAST_NAME` - Friendly name of this stream (eg. `Boston office`).
* `ICECAST_DESCRIPTION` - Description of the stream (eg. `it's a baby fuckin' whale, khed!`).
* `ICECAST_BITRATE_MODE` - `cbr`, `abr`, or `vbr`; defaults to `vbr`
* `ICECAST_QUALITY` - value depends on the bitrate mode; defaults to `0.8`
