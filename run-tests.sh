#!/bin/sh

set -e

trap stop_containers EXIT

function start_postgres(){
    echo "Starting Postgres Service Container..."
    docker-compose up -d --force-recreate event-store
    echo "Giving Postgres Time to Initialise..."
    sleep 3
}

function stop_containers() {
  echo "Stopping and Cleaning Up Containers..."
  docker-compose down -v --remove-orphans
}
if [[ "$1" != "--no-build" ]]; then
    echo "Starting Container Build..."
    docker build -t platform-deployer-verify-data-db-migrations:latest-tests .
fi
start_postgres

docker-compose run tests migrate
MIGRATION_RESULT=$?

if [[ $MIGRATION_RESULT == 0 ]]; then
    printf "\033[32m*******************************\n"
    printf "\033[32m** Migrations Test Succeeded **\n"
    printf "\033[32m*******************************\n\033[0m"
else
    printf "\033[31m****************************\n"
    printf "\033[31m** Migrations Test Failed **\n"
    printf "\033[31m****************************\n\033[0m"
    exit $MIGRATION_RESULT
fi
