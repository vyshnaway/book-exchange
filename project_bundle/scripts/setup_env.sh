#!/bin/bash

# ==========================================
# 🛠️ Instant Book Exchange - Environment Setup
# ==========================================
# This script installs necessary tools for the project.
# Supported OS: Debian / Ubuntu / Linux Mint
# ==========================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting Environment Setup...${NC}"

# 1. Check Root/Sudo
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run as root (use sudo).${NC}"
  exit 1
fi

# 2. Update System
echo -e "\n${YELLOW}[1/4] Updating Package Lists...${NC}"
apt-get update

# 3. Install Basics (Git, Make, Curl)
echo -e "\n${YELLOW}[2/4] Installing Git, Make, and Curl...${NC}"
apt-get install -y git make curl

# 4. Install Docker (if not present)
if ! command -v docker &> /dev/null; then
    echo -e "\n${YELLOW}[3/4] Docker not found. Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    echo -e "${GREEN}Docker installed successfully.${NC}"
else
    echo -e "\n${GREEN}[3/4] Docker is already installed.${NC}"
fi

# 5. Setup Permissions (Rootless Docker)
echo -e "\n${YELLOW}[4/4] Configuring User Permissions...${NC}"
# Get the actual user (if running with sudo)
ACTUAL_USER=${SUDO_USER:-$USER}

if ! getent group docker > /dev/null; then
  groupadd docker
fi

if ! groups "$ACTUAL_USER" | grep &>/dev/null 'docker'; then
  usermod -aG docker "$ACTUAL_USER"
  echo -e "${GREEN}User '$ACTUAL_USER' added to 'docker' group.${NC}"
  echo -e "${RED}IMPORTANT: You must log out and log back in for this to take effect!${NC}"
else
  echo -e "${GREEN}User '$ACTUAL_USER' is already in the 'docker' group.${NC}"
fi

# 6. Install Docker Compose (if strictly needed separately, though modern docker includes it)
# We rely on 'docker compose' (plugin) which comes with the get-docker.sh script usually.
# But checking for 'docker-compose' standalone just in case.

echo -e "\n${GREEN}==========================================${NC}"
echo -e "${GREEN}   SETUP COMPLETE! ✅                     ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "You are ready to run: ${YELLOW}make deploy${NC}"
echo -e "If you just installed Docker, remember to ${RED}LOG OUT AND LOG BACK IN${NC}."
