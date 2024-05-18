FROM ros:${templateOption:distro}-${templateOption:imageVariant}

ARG USERNAME=rosdev
ARG UID=1000
ARG GID=$UID

# Install some dependencies packages
RUN apt update -q \
    && apt upgrade -q -y \
    && apt install -y --no-install-recommends \
    software-properties-common \
    python3-pip \
    xauth \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create and switch to user
RUN groupadd -g $GID $USERNAME \
    && useradd -lm -u $UID -g $USERNAME -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME

# Create workspace so that user own this directory
RUN mkdir -p /home/$USERNAME/ros2_ws/src
WORKDIR /home/$USERNAME/ros2_ws

# Setup bashrc
## Make ros2 public to the system via `source` command
RUN echo 'source /opt/ros/'$ROS_DISTRO'/setup.bash' >> /home/$USERNAME/.bashrc

## Check if own build have been made; if yes, source it 
RUN cat << 'EOF' >> ~/.bashrc
if [ -d "/home/'$USERNAME'/ros2_ws/install" ]; then
    # Make own  public to the system via `source`
    source /home/'$USERNAME'/ros2_ws/install/setup.bash
else
    echo "/home/$USERNAME/ros2_ws/install has not yet been created."
fi
EOF

# Setup entrypoint
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
