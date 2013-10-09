<!--
Marked Style: GitHub
-->

# Ubuntu Modifications

This file documents my modifications to a base Ubuntu system for personal use.

## Base Package Setup

The following package list was created against Ubuntu 12.04 (precise).

```
apt-get install aptitude build-essential git ruby1.9.1-full zsh
exuberant-ctags
chsh -s /bin/zsh
```

## GUI system modifications

at end of /etc/gdm/Init/Default, to force numlock off:

```
if [ -x /usr/bin/numlockx ]; then
  /usr/bin/numlockx off
fi
```

To remap Caps Lock to be Control, write this to ~/.Xmodmap:
```
keycode 66 = Control_L
```

## X Configuration

See https://wiki.ubuntu.com/X/Config/Input

To make the Logitech TrackMan Marble FX scroll button work, copy the
file 99-trackman.conf (in the same directory as this file) to
/usr/share/X11/xorg.conf.d

Restart X for these changes to take effect.

## GNOME Configuration

Using gconf-editor or gconftool-2 as below, change the button order to
match OS X:

gconftool-2 --set /apps/metacity/general/button_layout --type string "close,minimize,maximize:"

In System > Preferences > CompizConfig Settings Manager > Window Rules, 
enable the plugin and set parameters as:
Sticky     class=Pidgin

## Network Configuration

Add domains to the DNS search path when using an automatic connection
with DHCP: (via https://help.ubuntu.com/community/NetworkManager0.7)

  First, look at the entries in /var/lib/dhcp3/dhclient-*.lease to
  obtain the DHCP provided DNS servers for this host.

  In the Network Manager applet, edit the network connection in
  question (e.g. "Auto eth0").  In the IPv4 Settings tab, choose
  "Automatic (DHCP) addresses only", fill in the DNS servers from
  the file above and add search domains as needed.
