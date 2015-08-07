#!/bin/bash

stub_file=/etc/unbound/unbound.conf.d/stub-zones.conf
server_conf=/etc/unbound/unbound.conf.d/quakecon.conf

for zone in $AUTHORITATIVE_ZONES; do
    echo "Adding stub-zone: $zone"
    if expr match $zone '.*\.arpa\.$'; then
	# Work around some weird unbound weirdness for private rDNS
	echo -e "\tlocal-zone: \"$zone\" nodefault" >> $server_conf
    fi
    echo -e "stub-zone:\n\tname: \"$zone\"" >> $stub_file
    for server in $AUTHORITATIVE_SERVERS; do
	echo -e "\tstub-addr: $server" >> $stub_file
    done
    echo "" >> $stub_file
done

cat $server_conf
cat $stub_file

if [ x$1 != "x" ]; then
    exec $@
else
    exec unbound -d
fi
