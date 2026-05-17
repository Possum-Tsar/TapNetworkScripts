#!/usr/bin/env bash

# cleanup old instances if rerun
ip link del tap0 2>/dev/null || true
ip link del br0 2>/dev/null || true

# create bridge interface
ip link add br0 type bridge

# disable /enable 0STP - OPTIONAL MULTICAST - Only enable when enabling an external network
#ip link set dev br0 type bridge stp_state 0 # disable
#ip link set dev br0 type bridge stp_state 1 # enable


# remove delays in forwarding - OPTIONAL - only enable  when stp_state 1
#echo 0 > /sys/class/net/br0/bridge/forward_delay
#echo 0 > /sys/class/net/br0/bridge/hello_time
#echo 0 > /sys/class/net/br0/bridge/max_age

# set bridge up
ip link set br0 up

# disable multicast snooping/filtering - OPTIONAL MULTICAST
echo 0 > /sys/class/net/br0/bridge/multicast_snooping
echo 0 > /sys/class/net/br0/bridge/multicast_querier
echo 2 > /sys/class/net/br0/bridge/multicast_router

# assign bridge IP
ip addr add 192.168.0.1/24 dev br0

# uncomment below and change interface name as need to attach to carrier  - OPTIONAL EXTERNAL NETWORK
#ip link set enp0s31f6 up
#ip link set enp0s31f6 master br0

# create , start, and attach tap to bridge
ip tuntap add dev tap0 mode tap user "$USER"
ip link set tap0 up
ip link set tap0 master br0

# uncomment below to enable permisuous mode - OPTIONAL PERMISCUOUS MODE
ip link set br0 promisc on
ip link set tap0 promisc on

# receive all multicast - OPTIONAL MULTICAST
ip link set br0 allmulticast on
ip link set tap0 allmulticast on

# set tunnel permissions
chown $USER /dev/net/tun

# change name to whichever qemu in use
setcap cap_net_admin,cap_net_raw+ep $(which qemu-system-mips)
