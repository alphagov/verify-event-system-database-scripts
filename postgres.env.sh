#!/bin/bash

# Source this script in your CLI session.
# Sets some PostgreSQL variables to make accessing a database simpler.

if [ "$#" -ne 1 ] ;
then
    echo "You must specify the Host URL to connect to. Quitting early."
    return 1;
fi

export PGHOST=$1
export PGUSER=iam_reader
export PGDATABASE=events
export PGSSLMODE=require

if ! command -v aws >/dev/null ;
then
    echo "AWS CLI not found. Quitting early."
    echo "The \"PGPASSWORD\" variable has not been set."
    echo "Either set it manually, or install the AWS CLI and try again."
    return 1;
fi
if [ -z ${AWS_ACCESS_KEY_ID} ] || [ -z ${AWS_SECRET_ACCESS_KEY} ] ;
then
    echo "AWS access or secret key not set."
    echo "Please authenticate to an appropriate AWS role."
    echo "Quitting early."
    return 1;
fi

export PGPASSWORD=$(aws rds generate-db-auth-token \
        --hostname ${PGHOST} \
        --port 5432 \
        --region eu-west-2 \
        --username ${PGUSER} \
)
echo "PostgreSQL environment variables exported. Please use \"psql\" to connect."
echo "If you cannot connect, try refreshing your AWS credentials and regenerating."
