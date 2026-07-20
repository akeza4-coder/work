#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Starting Firewall Configuration ==="

# 1. Fix the Ubuntu translation layer issue by enforcing legacy iptables
echo "Configuring iptables to use legacy backend..."
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy || true
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy || true

# 2. Define the Load Balancer IP
LB_IP="172.25.0.10"

# 3. Apply standard, baseline iptables rules
echo "Applying firewall rules..."

# Allow loopback interface traffic
sudo iptables -A INPUT -i lo -j ACCEPT

# Allow established and related traffic
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Requirement: Allow SSH on port 22 from anywhere
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Identify if this script is running on the Load Balancer or a Web Server based on hostname
HOSTNAME=$(hostname)

if [[ "$HOSTNAME" == *"lb"* ]]; then
    echo "Detected Load Balancer environment ($HOSTNAME)."
    # Requirement: Allow 443 from anywhere on LB
    sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
    # Allow port 80 on LB (useful for HTTPS redirects)
    sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
else
    echo "Detected Web Server environment ($HOSTNAME)."
    # Requirement: Allow HTTP on 80 ONLY from your LB
    sudo iptables -A INPUT -p tcp -s "$LB_IP" --dport 80 -j ACCEPT
fi

# Set default policy to drop all other incoming traffic
sudo iptables -P INPUT DROP

echo "Firewall rules applied successfully!"
sudo iptables -L -v -n
