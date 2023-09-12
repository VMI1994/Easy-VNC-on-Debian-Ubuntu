#!/bin/bash

clear
# Open port 5901 on ufw
sudo ufw allow 5901/tcp

# Update system before install
echo 'Updateing system before install'
sudo apt update && sudo apt upgrade -y

# Install dependencies
clear
echo 'Installing tightvncserver and lxde'
echo 'If prompted for a display manager, choose lightdm'
echo 'Press Enter to proceed'
read junk
sudo apt-get install sudo apt install xfce4 xfce4-goodies tightvncserver

# Choose password for VNC access
clear
echo "Choose a password to access VNC server"
vncpasswd

# Create service file for systemd
clear 
echo 'Creating service file for VNC service'






sudo cp servicefile /etc/systemd/system/vncserver@.service
sudo chmod 777 /etc/systemd/system/vncserver@.service

# Copy xstartup to users home directory
clear
echo 'Creating xstartup file'
cp xstartup ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Enable VNC service
clear
echo 'Enabling VNC service'
sudo systemctl daemon-reload
sudo systemctl enable vncserver@.service
sudo systemctl start vncserver@.service
sudo systemctl status vncserver@.service

clear
echo 'VNC service is installed and running'

exit
