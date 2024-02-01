FROM ros:${templateOption:distro}-${templateOption:imageVariant}

ARG USERNAME=rosdev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install some dependencies packages
RUN apt update -q \
    && apt upgrade -q -y \
    && apt install -y --no-install-recommends \
    software-properties-common \
    python3-pip \
    xauth \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create and switch to user 'rosdev'
RUN groupadd -g $GID rosdev \
    && useradd -lm -u $UID -g rosdev -s /bin/bash rosdev \
    && echo "rosdev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER rosdev

# Create workspace so that user 'rosdev' own this directory
RUN mkdir -p /home/rosdev/ros2_ws/src
WORKDIR /home/rosdev/ros2_ws

# Copy configuration files
RUN echo 'source /opt/ros/'$ROS_DISTRO'/setup.bash' >> /home/rosdev/.bashrc \
    && echo 'source /home/rosdev/ros2_ws/install/setup.bash' >> /home/rosdev/.bashrc

# Setup entrypoint
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
