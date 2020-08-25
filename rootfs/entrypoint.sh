#!/bin/bash

# Set DISPLAY variable
export DISPLAY=:20

# Configure screen resolution
Xvfb :20 -screen 0 1920x1080x16 &

# Start VNC server
x11vnc -passwd $1 -display :20 -N -forever &

# Start LXQt
/usr/bin/startlxqt &
