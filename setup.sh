#!/bin/bash
set -e

echo "Installing Docker..."
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker

echo "Starting changedetection.io..."
mkdir -p ./data
docker compose up -d

echo "Done. Access at http://$(curl -s https://checkip.amazonaws.com):5000"
