#!/bin/bash

# Update the package index
echo "Updating package index..."
sudo apt update

# Install prerequisites
echo "Installing prerequisites..."
sudo apt install -y curl

# Download and install the Node.js v20.x PPA (Personal Package Archive)
echo "Setting up Node.js 20.x repository..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Install Node.js
echo "Installing Node.js 20..."
sudo apt install -y nodejs

# Verify installation
echo "Node.js version:"
node -v

echo "npm version:"
npm -v

echo "Node.js 20 installation is complete!"
