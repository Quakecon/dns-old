FROM debian:jessie
MAINTAINER Shawn Nock <nock@nocko.se>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    nsd && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN mkdir /etc/nsd/zones /run/nsd && \
    rm /etc/nsd/nsd.conf

COPY nsd.conf /etc/nsd/
COPY db* /etc/nsd/zones/

ENV NSD_PORT 5353

CMD /usr/sbin/nsd -p $NSD_PORT
