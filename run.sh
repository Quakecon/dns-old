#!/bin/bash

tmpl=/etc/nsd/master.tmpl
pattern_file=/etc/nsd/nsd.conf.d/qcbase.conf 

master_ip=$(expr match $NSD_MASTER '\(.*\)@'||echo $NSD_MASTER)
master_port=$(expr match $NSD_MASTER '.*@\([0-9]*\)'||echo $NSD_PORT)
echo "Configuring master: $NSD_MASTER"
sed -e "s/x_MASTER_IP/$master_ip/g" -e "s/x_MASTER_PORT/$master_port/g" $tmpl >> $pattern_file

cat $pattern_file

if [ x$1 != "x" ]; then
    exec $1
else
    exec /usr/sbin/nsd -p $NSD_PORT
fi
