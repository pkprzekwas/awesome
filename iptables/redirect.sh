#!/bin/bash

# Simple script to redirect traffic from external port 80 to local 3000
set -xe

sudo iptables -t nat -A PREROUTING -i enp0s3 -p tcp --dport 80 -j REDIRECT --to-port 3000

# Support for looback
sudo iptables -t nat -I OUTPUT -p tcp -o lo --dport 80 -j REDIRECT --to-ports 3000
