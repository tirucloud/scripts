#!/bin/bash

# Update package index
sudo apt update

# Install MySQL server
sudo apt install -y mysql-server

# Start MySQL service
sudo systemctl start mysql

# Enable MySQL service to start on boot
sudo systemctl enable mysql

# Secure MySQL installation
sudo mysql_secure_installation

# Print MySQL version to verify installation
mysql --version

echo "MySQL installation completed successfully!"
