# Quakecon IT Recursive DNS Server

## Testing

1. `docker run -p 53:53/udp -p 53:53/tcp quakecon/dns:recursive`

2. `dig @127.0.0.1 google.com`

## Development

1. `git clone git@github.com/Quakecon/dns.git`

2. git checkout -b recursive origin/recursive

3. Edit config files / Dockerfile

4. `docker build -t qc-dns-recursive .`

5. docker run -p 53:53/udp -p 53:53/tcp qc-dns-recursive

6. Repeat 3--5 until the container works as expected

7. git commit+push, then Docker Hub Trusted Build will make the image available to the public at quakecon/dns:recursive

## Deployment

`docker run -p 53:53/tcp -p 53:53/udp quakecon/dns:auth-recursive`

Container ENV Variables of note are:
 - `AUTHORITATIVE_ZONES` A space separated list of zone names to forward to the AUTHORITATIVE_SERVERS
 - `AUTHORITATIVE_SERVERS` A space separated list of IPs or IP@PORT strings where records from the AUTHORITATIVE_ZONES can be resolved *authoritatively* (will not work for non-authoritative zones).

Example of overriding the defaults:

`docker run -e "AUTHORITATIVE_ZONES=\"at.quakecon.org\"" -e "AUTHORITATIVE_SERVERS=192.168.1.1" -p 53:53/udp -p 53:53/tcp quakecon/dns:recursive