#!/usr/bin/env bash

export FLYWAY_URL=jdbc:postgresql://$PGHOST:5432/$PGDATABASE
export FLYWAY_USER=$PGUSER
if [[ "$USE_IAM_AUTH" == "1" ]]; then
    export FLYWAY_PASSWORD=$(aws rds generate-db-auth-token --hostname ${PGHOST} --port 5432 --region eu-west-2 --username ${PGUSER})
else
    export FLYWAY_PASSWORD=$PGPASSWORD
fi

/flyway/flyway "$@"
