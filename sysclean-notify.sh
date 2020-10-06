#!/bin/bash
sudo -u $1 DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$2/bus notify-send "Hello handsome" "Install upgrades and run ~/dev/utils/sysclean.sh"
