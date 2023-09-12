#!/bin/bash

clear
# Open port 5901 on ufw
echo 'Open firewall port 5901'
sudo ufw allow 5901/tcp

# Update system before install
echo 'Updating system before install'
echo 'Press Enter to proceed'
read junk
sudo apt update && sudo apt upgrade -y

# Install dependencies
clear
echo 'Installing tightvncserver and xfce4'
echo 'If prompted for a display manager, choose lightdm'
echo 'Press Enter to proceed'
read junk
sudo apt install xfce4 xfce4-goodies tightvncserver

# Choose password for VNC access
clear
echo "Choose a password to access VNC server"
vncpasswd

# Create service file for systemd
clear 
echo 'Creating service file for VNC service'
sleep 2
cat servicefilepart1.txt > tmp
echo "User=$USER" >> tmp
echo "Group=$USER" >> tmp
echo "WorkingDirectory=/home/$USER" >> tmp
echo "PIDFile=/home/$USER/.vnc/%H:%i.pid" >> tmp
cat servicefilepart2.txt >> tmp
chmod 777 tmp
sudo mv tmp /etc/systemd/system/vncserver@1.service

# Copy xstartup to users home directory
clear
echo 'Creating xstartup file'
sleep 2
cp xstartup ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Enable VNC service
clear
echo 'Enabling VNC service'
sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1.service
sudo systemctl status vncserver@1.service

exit
