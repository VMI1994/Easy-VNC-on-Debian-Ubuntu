#!/bin/bash

clear
# Update system before install
echo 'Updateing system before install'
sudo apt update && sudo apt upgrade -y

# Install dependencies
clear
echo 'Installing tightvncserver and lxde'
echo 'If prompted for a display manager, choose lightdm'
echo 'Press Enter to proceed'
read junk
sudo apt-get install lxde tightvncserver autocutsel

# Choose password for VNC access
clear
echo "Choose a password to access VNC server"
vncpasswd

# Create service file for systemd
clear 
echo 'Creating service file for VNC service'
cat servicefilepart1.txt > tmp
echo "User=$USER" >> tmp
cat servicefilepart2.txt >> tmp
chmod 777 tmp
sudo cp tmp /etc/systemd/system/vncserver@:1.service

# Copy xstartup to users home directory
clear
echo 'Creating xstartup file'
cp xstartup ~/.vnc/xstartup

# Enable VNC service
clear
echo 'Enabling VNC service'
sudo systemctl daemon-reload
sudo systemctl enable vncserver@:1.service
sudo systemctl start vncserver@:1.service
sudo systemctl status vncserver@:1.service

clear
echo 'VNC service is installed and running'

exit
