#!/bin/sh

# ZNC. Same thing with permissions...
chown -R znc:znc /znc-data
chmod 644 /znc-data/configs/znc.conf
sudo -H -u znc bash -c "znc --foreground --datadir=/znc-data" &

# ngircd
chown -R irc:irc /etc/ngircd
/usr/bin/supervisord -n
