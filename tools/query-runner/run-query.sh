#!/usr/bin/env bash

QUERY=${@}
echo "Running '${QUERY}' on '${PGHOST}'"

export PGPASSWORD=$(aws rds generate-db-auth-token --hostname "${PGHOST}" --port 5432 --region eu-west-2 --username "${PGUSER}")

psql "postgres://${PGUSER}@${PGHOST}:5432/events" -c "${QUERY}"