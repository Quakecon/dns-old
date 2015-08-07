# Quakecon IT Authoritative DNS Server (SLAVE)

## Testing

1. `docker run -p 53:5353/udp quakecon/dns:auth-slave`

2. `dig @127.0.0.1 quakeconcdn.org`

## Development

1. `git clone git@github.com/Quakecon/dns.git`

2. git checkout -b auth-slave origin/auth-slave

3. Edit config files / Dockerfile

4. `docker build -t dns-auth-slave .`

5. `docker run -p 53:5353/udp -it dns-auth-slave`

6. Do 3--5 until you are happy with the results 

7. git commit+push, then Docker Hub Trusted Build will make the image available at quakecon/dns:auth-slave

## Deployment

`docker run -p 5353:5353/udp -p 5353:5353/tcp quakecon/dns:auth-master`

Container ENV Variables of note are:
 - `NSD_MASTER` An IP addresses or <ip address>@<port> string that from which to request-xfr / allow-notify [default: `"ns1@5353`]

Default NSD_MASTER value is sane for recent Quakecon years, but
exposed for easy changes or eventual coreos/etcd/fleet deployment

Example of overriding the defaults:

`docker run -e"NSD_MASTER=192.168.1.1" -p 5353:5353/tcp 5353:5353/udp quakecon/dns:auth-slave`