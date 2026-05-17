#!/usr/bin/env bash

ifconfig eth0 192.168.0.2 up
route add default gw 192.168.0.1

# ensure multicast reception is not filtered - OPTIONAL MULTICAST
ip link set eth0 multicast on
ip link set eth0 allmulticast on

# join common discovery groups - other multicast groups can be added in the same method - OPTIONAL MULTICAST
ip maddr add 239.255.255.250 dev eth0   # SSDP
ip maddr add 224.0.0.251 dev eth0       # mDNS
