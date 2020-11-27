# Speakeasy IRC/Docker setup

Docker configuration running ZNC and ngircd setup in a way which only allows users
setup via ZNC to connect.

Included are instructions for adding Tor support (intentionally left out) and `ufw`
on the host. This way I could have various Docker services which shared the same
`.onion` address.

Included is a connection guide (`CONNECTING.md`) which you can send to users
you've setup.

## Why no TLS/SSL?

Tor is already end-to-end encrypted and also a partial point of a hidden
service is to anonymize your server, whereas TLS/SSL strictly de-anonymizes
your server.

## Preconfiguration

Edit the `znc` and `ngircd` configurations in `speakeasy-data/`.

## Create the Docker network

I created a Docker network for a few services I run in Docker, allowing me to
use the host's Tor configuration, enabling all of these services to use the
same `.onion` address.

```bash
docker network create --subnet=172.18.0.0/16 servicenet
```

## Build & run

```bash
docker build -t speakeasy .
docker run -d -v $(pwd)/speakeasy-data/tor:/var/lib/tor -v $(pwd)/speakeasy-data/znc:/znc-data -v $(pwd)/speakeasy-data/ngircd:/etc/ngircd --restart=always --net servicenet --hostname=speakeasy --ip=172.18.0.67 speakeasy
```

## Inviting users

Send users the `CONNECTING.md` file. You will have to give them your `.onion`
address.

## Adding to `/etc/tor/torrc`

```
HiddenServiceDir /var/lib/tor/hidden_service
HiddenServicePort 6667 172.18.0.67:6667
```

## Manage users (ZNC)

You will use the ZNC web interface to manage users and their access to the server.

The ZNC web interface is located at `http://onionaddress:6667` where
"onionaddress" is your `.onion` address. Access the ZNC web interface using [Tor
Browser](https://www.torproject.org/).

The first time you try to access the ZNC web interface with Tor Browser you'll
get an error: by default Tor doesn't allow you to visit websites served on port
6667. Change this behavior by visiting `about:config`, creating the entry
`network.security.ports.banned.override` with a string value `6667`.

**IMPORTANT:** The default admin username is `admin` and the password is
`admin`. It is important that you change this password immediately!

### Private channels

The configuration setup by default doesn't let users create new channels and
the configuration has two channels which are password protected...

You're supposed to add users to specific password-protected channels defined in
`ngircd.conf`...

### Connecting ZNC account to IRC

For network add `127.0.0.1` on port `6666` no SSL.

Also, for users to avoid missing messages when disconnected:

  * https://wiki.znc.in/Clearbufferonmsg
  * https://wiki.znc.in/Configuration

## Troubleshooting

### Log into the running container

You can troubleshoot with `docker exec -it containerid bash` if you
have problems.
