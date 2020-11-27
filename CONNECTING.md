# Connecting to the Speakeasy

IRC server which only allows connections from ZNC accounts the admin has added.
The ZNC can only be connected to via Tor.

If you're new to IRC I strongly recommend Hexchat. In fact, a lot of this guide
will hand-hold you through getting set up in any Debian variant Linux distro.

I also like Weechat.

## Setup Tor

You can only connect to the ZNC account created for you using Tor. Tor anonymizes
you and it anonymizes the server. It also offers end-to-end encryption.

Please make sure you have Tor installed:

`sudo apt install tor`

In your IRC client you'll want to set the proxy settings to hostname 127.0.0.1
and port 9050 using SOCKS5, for all connections.

To setup Tor in Hexchat look at the menu bar of the main Hexchat window and go
to settings, then click "preferences" from the menu that appears. Then in the
left pane click "network setup" and under *proxy sever* enter in the hostname,
port, and set type to SOCKS5. Set "use proxy for all connections."

**NOTE:** for Windows the port is 9150.

## Connecting to your ZNC account

You connect to the IRC server through a ZNC account created for you.

### ZNC Connection settings

  * Host: something.onion
  * Port: 6667
  * SSL only/Use SSL for all servers on this network
  * Accept invalid SSL certificates

So in Hexchat:

  1. In the network list, *add* a new network, call it "Speakeasy."
  1. Click "edit" on the new network you added (the one you called "Speakeasy")
  1. you'll look at the *servers* tab, click "add" and then enter `something.onion/6667`
  1. Check "connect to this network automatically"
  1. Check "use SSL for all the servers on this network"
  1. Check "accept invalid SSL certificates"
  1. Enter your username I gave you for your *nick name*
  1. Enter whatever for *second choice*
  1. Enter whatever for *real name*
  1. Enter your username I gave you for your *user name*
  1. Change the *login method* drop down to *server password (/PASS)*
  1. Set the *password* to `username:password` (the *user name* I gave you, plus the password I gave you for your user account)

Side note: if you have a weird client/want to identify manually you can use the command `/quote PASS someuser:somepassword`.

## Bonus: OTR

Go the extra mile and install OTR for your client. If you're using Hexchat I strongly recommend [hexchat-otr](https://github.com/TingPing/hexchat-otr), which you can install in Debian with `sudo apt install hexchat-otr`.

Read the readme here: https://github.com/TingPing/hexchat-otr

## Weechat

```
/set irc.server.default.nicks "zncusername"
/server add speakeasy wmli4d4msjqkzcd2.onion
/set irc.server.speakeasy.autoconnect on
/set irc.server.speakeasy.addresses "wmli4d4msjqkzcd2.onion/6667"
/proxy add tor socks5 127.0.0.1 9050
/set irc.server.speakeasy.proxy "tor"
/set irc.server.speakeasy.username "zncusername"
/set irc.server.speakeasy.password zncusername:zncpassword
/connect speakeasy
```

there's another way to do this so i don't have to `/quote pass ****` it looks
like `/set irc.server.freenode.sasl_password "${sec.data.freenode_password}"`

Also check out:
```
/secure passphrase *********************************
/secure set speakeasy_password *********************************
```

Other useful docs:

  * https://weechat.org/files/doc/devel/weechat_faq.en.html
  * https://trac.torproject.org/projects/tor/wiki/doc/TorifyHOWTO/WeeChat
  * https://weechat.org/files/doc/stable/weechat_quickstart.en.html
  * https://kmacphail.blogspot.com/2011/09/using-weechat-with-freenode-basics.html
  * https://weechat.org/files/doc/stable/weechat_quickstart.en.html
  * https://weechat.org/files/doc/stable/weechat_user.en.html
