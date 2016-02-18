FROM resin/rpi-raspbian:wheezy-20151202

ADD src /tmp/src/
RUN /tmp/src/config.sh

ENV PCM_CAPTURE_SOURCE "Line"

## this seems to work well with an Apple TV as the source
ENV INPUT_SAMPLERATE 48000

ENV ICECAST_BITRATE_MODE vbr
ENV ICECAST_QUALITY 0.8

ENV ICECAST_PROTO http
# ENV ICECAST_SERVER
# ENV ICECAST_PORT
# ENV ICECAST_PASSWORD
# ENV ICECAST_MOUNT
# ENV ICECAST_NAME
# ENV ICECAST_DESCRIPTION

# ENV HUBOT_URL

CMD ["/usr/bin/supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
