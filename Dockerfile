FROM ros:latest

# Skip keyboard-configuration prompt for lxqt install
ENV DEBIAN_FRONTEND noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    ~nros-${ROS_DISTRO}-rqt*
    lxqt \
    ros-${ROS_DISTRO}-turtlesim
    x11vnc \
    xvfb

# Keyboard settings
COPY ./rootfs/etc/default/keyboard /etc/default/

# LXQt session configuration
RUN mkdir -p /root/.config/lxqt/
COPY ./rootfs/root/.config/lxqt/session.conf /root/.config/lxqt/

# Set environmental variable for xvfb
ENV DISPLAY :20

# Expose port 5920 to view display using VNC Viewer
EXPOSE 5920

# Set working directory
WORKDIR /

# Copy entrypoint.sh
COPY ./rootfs/entrypoint.sh /

# Execute startup script
ENV VNC_PASSWORD ros
ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh $VNC_PASSWORD"]
