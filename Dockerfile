FROM ros:foxy

# Skip keyboard-configuration prompt for lxqt install
ENV DEBIAN_FRONTEND noninteractive

# Install required packages
RUN apt-get update
RUN apt-get install -y build-essential lxqt x11vnc xvfb gazebo11 libgazebo11-dev ros-foxy-gazebo-ros-pkgs

# Keyboard configuration
COPY ./keyboard /etc/default/keyboard

# Set working directory
WORKDIR /

# Set environmental variable for display
ENV DISPLAY :20

# Expose port 5920 to view display using VNC Viewer
EXPOSE 5920