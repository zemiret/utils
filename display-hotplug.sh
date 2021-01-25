#!/bin/bash

DP1_STATUS=$(</sys/class/drm/card0/card0-eDP-1/status )
HDMI_STATUS=$(</sys/class/drm/card0/card0-HDMI-A-2/status)

user=zemiret
userid=$(id $user | grep -o -e 'uid=[0-9]*' | grep -o -e '[0-9]*')

if [ $HDMI_STATUS == "connected" ]; then
	nohup sleep 1 > /dev/null 2>&1 && xrandr --output HDMI2 --auto --output eDP1 --off &&  xrandr --output HDMI2 --auto --output eDP1 --mode 1280x720 --right-of HDMI2 &
	sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$userid/bus /usr/bin/notify-send --urgency=low -t 5000 "Damn visuals!" "HDMI and display connected"
elif [ $DP1_STATUS == "connected" ]; then
	xrandr --output HDMI2 --off --output eDP1 --mode 1920x1080
	sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$userid/bus /usr/bin/notify-send --urgency=low -t 5000 "Damn visuals!" "Only laptop"
else
	xrandr --auto
fi

