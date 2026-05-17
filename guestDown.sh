#!/usr/bin/env bash

# remove multicast group memberships - OPTIONAL MULTICAST
ip maddr del 239.255.255.250 dev eth0 2>/dev/null || true
ip maddr del 224.0.0.251 dev eth0 2>/dev/null || true

# disable multicast reception flags - OPTIONAL MULTICAST
ip link set eth0 allmulticast off
ip link set eth0 multicast off

# remove routing
route del default gw 192.168.0.1 2>/dev/null || true

# clear IP / bring interface down
ifconfig eth0 0.0.0.0 2>/dev/null || true
ifconfig eth0 down 2>/dev/null || true
