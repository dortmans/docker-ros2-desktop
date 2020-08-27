FROM ros:latest

# Skip keyboard-configuration prompt for lxqt install
ENV DEBIAN_FRONTEND noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    ~nros-${ROS_DISTRO}-rqt* \
    gazebo11 \
    libgazebo11-dev \
    lxqt \
    ros-${ROS_DISTRO}-demo-nodes-cpp \
    ros-${ROS_DISTRO}-demo-nodes-py \
    ros-${ROS_DISTRO}-gazebo-ros-pkgs \
    ros-${ROS_DISTRO}-turtlesim \
    x11vnc \
    xvfb && \
    rm -rf /var/lib/apt/lists/*

# Keyboard settings
COPY ./rootfs/etc/default/keyboard /etc/default/

# Gazebo11 GUI initialization
RUN mkdir -p /root/.gazebo/
COPY ./rootfs/root/.gazebo/gui.ini /root/.gazebo/

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
