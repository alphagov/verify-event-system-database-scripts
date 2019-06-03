#!/usr/bin/env bash

echo "Starting Container Build..."
docker build -t platform-deployer-verify-data-db-migrations:latest-tests .
