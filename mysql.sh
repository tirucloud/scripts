#!/bin/bash

# A shell script to install MySQL on Ubuntu

echo "Starting MySQL installation on Ubuntu..."

# Update package list
sudo apt update -y
if [ $? -ne 0 ]; then
  echo "Failed to update package list. Exiting."
  exit 1
fi

# Install MySQL server
sudo apt install mysql-server -y
if [ $? -ne 0 ]; then
  echo "Failed to install MySQL. Exiting."
  exit 1
fi

# Secure MySQL installation
echo "Running MySQL secure installation..."
sudo mysql_secure_installation <<EOF

y
Root@123
Root@123
y
y
y
y
EOF

if [ $? -ne 0 ]; then
  echo "Failed to secure MySQL installation. Exiting."
  exit 1
fi

# Enable and start MySQL service
sudo systemctl enable mysql
sudo systemctl start mysql

# Check MySQL status
sudo systemctl status mysql | grep "active (running)"
if [ $? -eq 0 ]; then
  echo "MySQL is installed and running successfully."
else
  echo "MySQL installation failed or service is not running."
  exit 1
fi

# Display MySQL version
mysql --version

echo "MySQL installation is complete."
