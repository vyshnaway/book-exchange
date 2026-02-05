#!/bin/bash

# Deploy script for Instant Book Exchange
set -e

echo "Starting deployment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo "Error: Docker is not running."
  exit 1
fi

# Build and start services
echo "Building and starting services..."
docker-compose up --build -d

echo "Services started."
echo "Frontend: http://localhost:3000"
echo "Backend: http://localhost:8000"
echo "Admin: http://localhost:8000/admin"

echo "To view logs: docker-compose logs -f"
