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
COPY slave.tmpl /etc/nsd/
COPY nsd.conf.d/qcbase.conf /etc/nsd/nsd.conf.d/
COPY db* /etc/nsd/zones/
COPY run.sh /

RUN chmod +x /run.sh

ENV NSD_PORT 5353
ENV NSD_SLAVES "172.16.1.103@5353 172.16.1.104@5353" 

EXPOSE $NSD_PORT
EXPOSE $NSD_PORT/udp

CMD /run.sh
