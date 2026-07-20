#!/bin/bash

# Define your Load Balancer IP address
LB_IP="192.168.1.100"

echo "Applying iptables rules..."

# 1. Flush (delete) all existing rules
sudo iptables -F
sudo iptables -X

# 2. Set default policies (Drop incoming, Allow outgoing)
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

# 3. Allow loopback traffic (internal system communication)
sudo iptables -A INPUT -i lo -j ACCEPT

# 4. Allow already established and related connections
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 5. Requirement: Allow HTTP (Port 80) ONLY from Load Balancer
sudo iptables -A INPUT -p tcp -s "$LB_IP" --dport 80 -j ACCEPT

# 6. Requirement: Allow SSH (Port 22) from anywhere
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 7. Requirement: Allow HTTPS (Port 443) from anywhere
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

echo "Rules applied successfully!"
sudo iptables -L -v -n
