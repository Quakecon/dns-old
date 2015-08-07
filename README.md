# Quakecon IT Authoritative DNS Server (Master)

## Testing

1. `docker run -p 53:5353/udp quakecon/dns:auth-master`

2. `dig @127.0.0.1 quakeconcdn.org`

## Development

1. `git clone git@github.com/Quakecon/dns.git`

2. git checkout -b auth-master origin/auth-master

2. Edit config files / Dockerfile

3. `docker build .`

4. git commit+push, then Docker Hub Trusted Build will make the image available if it's building correctly.

## Deployment

`docker run -P quakecon/dns:auth-master`

Container ENV Variables of note are:
 - `NSD_PORT` Adjust the port that the master listens on (tcp and udp) [defualt: 5353]
 - `NSD_SLAVES` A space separated list of IP addresses or <ip address>@<port> strings [default: `"ns2@$NSD_PORT ns3@$NSD_PORT"`] 

Default NSD_SLAVE value is sane for recent Quakecon years, but exposed
for easy changes or eventual coreos/etcd/fleet deployment

Example of overriding the defaults:

`docker run -e"NSD_PORT=53" -e"NSD_SLAVES=\"192.168.1.1@53 192.168.1.2@53\"" -P quakecon/dns:auth-master