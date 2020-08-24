#!/bin/bash

# Set DISPLAY variable
export DISPLAY=:20

# Configure screen resolution
#Xvfb :20 -screen 0 640x640x16 &
Xvfb :20 -screen 0 1920x1080x16 &

# Start VNC server
x11vnc -passwd ros -display :20 -N -forever &

# Configure Gazebo windows size on startup
#mkdir -p ~/.gazebo/
#cp /app/gui.ini ~/.gazebo/

# Run Gazebo
#gazebo &

mkdir -p ~/.config/lxqt/
cp /app/session.conf ~/.config/lxqt/session.conf

/usr/bin/startlxqt &