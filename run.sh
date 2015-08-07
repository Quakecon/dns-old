#!/bin/bash

tmpl=/etc/nsd/slave.tmpl
pattern_file=/etc/nsd/nsd.conf.d/qcbase.conf 

for slave in $NSD_SLAVES; do
    slave_ip=$(expr match $slave '\(.*\)@'||echo $slave)
    slave_port=$(expr match $slave '.*@\([0-9]*\)'||echo $NSD_PORT)
    echo "Configuring slave: $slave"
    sed -e "s/x_SLAVE_IP/$slave_ip/g" -e "s/x_SLAVE_PORT/$slave_port/g" $tmpl >> $pattern_file
done

if [ x$1 != "x" ]; then
    exec $1
else
    exec /usr/sbin/nsd -p $NSD_PORT
fi
