#!/bin/bash
# shellcheck disable=SC1091,SC2046,SC2086
cd "$(dirname "$0")" || exit 1
source test-utils.sh

# Template specific tests
check "distro" '[ -n "$ROS_DISTRO" ]'
check "ros2" '[source /opt/ros/$ROS_DISTRO/setup.bash --]'

# Report result
reportResults
