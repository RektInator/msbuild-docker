#!/usr/bin/env bash

# create wine prefix
export WINEDLLOVERRIDES="mscoree="
export WINEDEBUG="-all"
wineboot --init

# install dotnet 4.8
winetricks --force --unattended dotnet48 win10

# kill wineserver
wineserver --kill

# download the windows SDK
wget -q https://download.microsoft.com/download/d/8/f/d8ff148b-450c-40b3-aeed-2a3944e66bbd/windowssdk/winsdksetup.exe -O ${HOME}/.cache/winsdksetup.exe

# install the windows SDK
wine64 ${HOME}/.cache/winsdksetup.exe /norestart /q /installpath "Z:\\opt\\winsdk\\"

# kill wineserver
wineserver --kill
