#!/bin/bash

# install wine
dpkg --add-architecture i386
wget -qO- https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
apt-add-repository "deb http://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main"
apt update
apt install --install-recommends winehq-stable winbind cabextract -y

# install winetricks
wget -q https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /usr/bin/winetricks
chmod +x /usr/bin/winetricks
