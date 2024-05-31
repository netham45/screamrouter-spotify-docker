#!/bin/bash -e
rm -rf /tmp/* /tmp/.X* /run/dbus/pid || true
export PULSE_COOKIE=/var/run/pulse/.config/pulse/cookie
export DISPLAY=:0.0
dbus-daemon --system
avahi-daemon &
export DBUS_SESSION_BUS_ADDRESS="$(dbus-daemon --session --fork --print-address)"
pulseaudio --system --disallow-exit -D
pactl load-module module-rtp-send format=s16le channels=2 rate=44100 source=auto_null.monitor destination=$RTP_TARGET port=$RTP_PORT mtu=1164
cd /app
./xtigervnc.sh &
./openbox.sh &
ulimit -n 1024
spotify --no-zygot --disable-gpu