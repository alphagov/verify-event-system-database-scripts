#!/bin/sh

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

echo "Starting Container Build..."
docker-compose build

start_postgres

docker-compose run tests migrate
MIGRATION_RESULT=$?

stop_containers

if [[ $MIGRATION_RESULT == 0 ]]; then
    echo "\033[32m*******************************"
    echo "\033[32m** Migrations Test Succeeded **"
    echo "\033[32m*******************************"
else
    echo "\033[31m****************************"
    echo "\033[31m** Migrations Test Failed **"
    echo "\033[31m****************************"
    exit $MIGRATION_RESULT
fi
