#!/bin/bash

# create wine prefix
export WINEDLLOVERRIDES="mscoree="
export WINEDEBUG="-all"
wineboot --init

# install dotnet 4.8
winetricks --force -q dotnet48

# kill wineserver
wineserver -k

# download the windows SDK
wget -q https://download.microsoft.com/download/d/8/f/d8ff148b-450c-40b3-aeed-2a3944e66bbd/windowssdk/winsdksetup.exe -O winsdksetup.exe

# set windows version to win10
winetricks win10

# install the windows SDK
wine64 winsdksetup.exe /norestart /q /installpath "Z:\\opt\\winsdk\\"

# kill wineserver
wineserver -k
