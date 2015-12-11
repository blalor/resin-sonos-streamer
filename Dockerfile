FROM resin/rpi-raspbian:wheezy-20151202

RUN apt-get update && apt-get install dropbear

ADD start /start

RUN chmod a+x /start

CMD /start
