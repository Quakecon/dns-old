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
COPY master.tmpl /etc/nsd/
COPY nsd.conf.d/qcbase.conf /etc/nsd/nsd.conf.d/

ENV NSD_PORT 5353
ENV NSD_MASTER "172.16.1.102@$NSD_PORT"

EXPOSE $NSD_PORT
EXPOSE $NSD_PORT/udp

COPY run.sh /
RUN chmod +x /run.sh
CMD /run.sh
