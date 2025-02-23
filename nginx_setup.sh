#!/bin/bash

#Bash Script automates the setup of an Nginx server

echo "Bash Script to automate server to setup for Nginx"

#Define log file

LOG_FILE="/var/log/nginx_setup.log"

#Function to log messages

log() {
    echo "$(date): $1" | tee -a "$LOG_FILE"
}

#Ensure the script is run as root

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo ./nginx_setup.sh)"
    exit 1

fi

log "Starting Nginx installation..."

#Update package lists

log "Updating package lists..."

apt update -y && apt upgrade -y

#Install Nginx

log "Installing Nginx..."

apt install nginx -y

#Start Nginx using 'service' for WSL compatibility

log "Starting Nginx Service..." 

service nginx start

#Enable Nginx at boot for  non-WSL systems
if [[ $(ps -p 1 -o comm=) != "init" ]]; then
    log "Enabling Nginx to start at boot..."
    update-rc.d nginx defaults
fi

#Check if ufw (firewall) is install before configuring
if command -v ufw &> /dev/null; then
    log "Configuring firewall rules..."
    ufw allow 'Nginx Full'
    ufw enable
else
    log "Skipping firewall configuration (ufw not installed)."


fi

#Create a sample webpage

WEB_DIR="/var/www/html"
log "Creating a sample webpage in $WEB_DIR"
echo "<h1>Welcome to My Automated Nginx Server</h1>" > "$WEB_DIR/index.html"

#Restarting Nginx to apply changes
log "Restarting Nginx..."
service nginx restart

log "Nginx setup completed successfully!"
log "Visit http://localhost or your server IP to see the web page."
