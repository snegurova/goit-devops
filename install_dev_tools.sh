#!/bin/bash

set -e

echo "Starting installation of development tools..."

if ! command -v docker &> /dev/null; then
  sudo apt update -y
  sudo apt install -y ca-certificates curl gnupg lsb-release
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update -y
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo systemctl enable --now docker
fi

if ! docker compose version &> /dev/null; then
  sudo apt install -y docker-compose
fi

if ! command -v python3 &> /dev/null; then
  sudo apt install -y python3 python3-pip
fi

py_ok=$(python3 -c 'import sys; print(sys.version_info[:2] >= (3,9))')
if [ "$py_ok" != "True" ]; then
  sudo apt update -y
  sudo apt install -y software-properties-common
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt update -y
  sudo apt install -y python3.10 python3.10-venv python3.10-distutils
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
  sudo apt install -y python3-pip
fi

if ! python3 -m django --version &> /dev/null; then
  pip3 install --user Django
fi

echo "Development tools installation completed."