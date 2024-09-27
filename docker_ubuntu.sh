#!/bin/bash

# Update the package index
echo "Updating package index..."
sudo apt update

# Uninstall old versions of Docker if they exist
echo "Removing old versions of Docker, if any..."
sudo apt remove -y docker docker-engine docker.io containerd runc

# Install packages to allow apt to use a repository over HTTPS
echo "Installing prerequisites..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository for Docker
echo "Setting up Docker stable repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
echo "Updating package index..."
sudo apt update

# Install Docker Engine
echo "Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker --version

# Install Docker Compose plugin
echo "Installing Docker Compose plugin..."
sudo apt install -y docker-compose-plugin

# Verify Docker Compose installation
echo "Verifying Docker Compose installation..."
docker compose version

# Enable Docker service to start on boot
echo "Enabling Docker to start on boot..."
sudo systemctl enable docker

echo "Docker and Docker Compose installation completed successfully!"
