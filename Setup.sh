#!/bin/bash

# Update system before install
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt-get install tightvncserver autocutsel

# Choose password for VNC access
echo "Choose a password to access VNC server"
vncpasswd

# Create service file for systemd
sudo cat servicefilepart1.txt > /etc/systemd/system/vncserver@:1.service
sudo echo "User=$USER" >> /etc/systemd/system/vncserver@:1.service
sudo cat servicefilepart2.txt >> /etc/systemd/system/vncserver@:1.service

# Copy xstartup to users home directory
cp xstartup ~/.vnc/xstartup

# Enable VNC service
sudo systemctl daemon-reload
sudo systemctl enable vncserver@:<display>.service
sudo systemctl start vncserver@:<display>.service
sudo systemctl status vncserver@:<display>.service

exit
