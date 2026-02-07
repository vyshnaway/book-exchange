#!/bin/bash

# ==========================================
# 🚀 Instant Book Exchange - Deployment Script
# ==========================================
set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting deployment sequence...${NC}"

# ------------------------------------------
# 1. Pre-flight Checks
# ------------------------------------------
echo -e "\n1. Checking Environment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}Error: Docker is NOT running.${NC}"
    echo "Please start Docker Desktop or the Docker daemon and try again."
    exit 1
fi

# Check essential ports
for port in 3000 8000 5432; do
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null ; then
        echo -e "${YELLOW}Warning: Port $port is in use.${NC}"
        echo "The script will attempt to free it by stopping containers, but if it's another app, this might fail."
    fi
done

# ------------------------------------------
# 2. Cleanup
# ------------------------------------------
echo -e "\n2. Cleaning up previous deployment..."
docker-compose down --remove-orphans
echo -e "${GREEN}Cleanup complete.${NC}"

# ------------------------------------------
# 3. Build & Start
# ------------------------------------------
echo -e "\n3. Building and Starting Services..."
echo "(This might take a minute if building for the first time)"
docker-compose up --build -d

# ------------------------------------------
# 4. Health Check (Polling)
# ------------------------------------------
echo -e "\n4. Verifying System Health..."
echo "Waiting for Database to be ready..."

RETRIES=30
while [ $RETRIES -gt 0 ]; do
    HEALTH=$(docker inspect --format='{{.State.Health.Status}}' repo-db-1 2>/dev/null || echo "starting")
    if [ "$HEALTH" == "healthy" ]; then
        echo -e "${GREEN}Database is Healthy! 🟢${NC}"
        break
    fi
    echo "Waiting for DB... ($RETRIES retries left)"
    sleep 2
    RETRIES=$((RETRIES-1))
done

if [ $RETRIES -eq 0 ]; then
    echo -e "${RED}Timeout waiting for Database.${NC}"
    echo "Check logs with: docker-compose logs db"
    exit 1
fi

echo -e "\nRunning user creation script..."
docker-compose exec web python create_demo_users.py


# ------------------------------------------
# 5. Success
# ------------------------------------------
echo -e "\n${GREEN}==========================================${NC}"
echo -e "${GREEN}   DEPLOYMENT SUCCESSFUL! 🚀              ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "Frontend : http://localhost:3000"
echo -e "Backend  : http://localhost:8000"
echo -e "Admin    : http://localhost:8000/admin"
echo -e "------------------------------------------"
echo -e "To follow logs: ${YELLOW}docker-compose logs -f${NC}"
