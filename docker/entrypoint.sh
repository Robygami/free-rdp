#!/bin/bash

adduser --disabled-password --gecos "" $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
adduser $USERNAME sudo

/etc/init.d/dbus start
/etc/init.d/xrdp start

tail -f /var/log/xrdp.log
