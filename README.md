# Tap Network Scripts

This is a set of scripts for starting and stopping a TAP network interface cleanly so it can be attached to QEMU virtual machines.

tapUp.sh and tapDown.sh are intended to be run on the host machine and are responsible for creating a Linux bridge (br0) and attaching a TAP interface (tap0) to it, optionally forwarding traffic to an external network interface.

They also include optional configurations for multicast traffic, promiscuous mode, and attaching the TAP interface to an existing network interface or bridge. These options can be modified as needed by commenting/uncommenting lines or adjusting the script.

Currently, the scripts are configured for use with `qemu-system-mips`, but this can be changed depending on the required QEMU system architecture.

guestUp.sh and guestDown.sh configure the network stack inside the QEMU guest (IP address, gateway, and multicast behavior). The guest interface is connected to the host bridge through QEMU’s TAP device backend.

They include optional support for multicast traffic and joining specific multicast groups. Currently, the scripts include support for SSDP and mDNS multicast groups.
