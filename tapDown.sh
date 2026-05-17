#!/usr/bin/env bash

set +e

# detach physical NIC if attached
# ip link set enp0s31f6 nomaster

# remove tap interface
if ip link show tap0 &>/dev/null; then
    ip link set tap0 nomaster
    ip link set tap0 down
    ip tuntap del dev tap0 mode tap
fi

# remove bridge
if ip link show br0 &>/dev/null; then
    ip link set br0 down
    ip link del br0 type bridge
fi

ip link show
