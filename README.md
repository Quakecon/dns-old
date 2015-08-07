# Quakecon IT Authoritative DNS Server

## Testing

1. `docker run -p 53:5353/udp quakecon/dns-auth-master`

2. `dig @127.0.0.1 quakeconcdn.org`

## Development

1. `git clone git@github.com/Quakecon/dns-auth-master.git`

2. Edit config files / Dockerfile

3. `docker build .`

4. git commit+push, then Docker Hub Trusted Build will make the image available if it's building correctly.