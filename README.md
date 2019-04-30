# verify-event-system-database-scripts

SQL scripts and schemas for the Event System database.

## Migrations

The migrations directory holds the SQL scripts which were used to create the current database. They are used by the
[verify-event-recorder-service](https://github.com/alphagov/verify-event-recorder-service) and the
[verify-billing-reporter](https://github.com/alphagov/verify-billing-reporter) tests.

## Permissions

The permissions directory contains the SQL scripts that were used to create and then later revoke the reader and writer
users. These were replaced by IAM permissions. Only here as a historical reference.


## Migrations Docker Image

The migrations are built into a Docker image based on the Flyway database migrations tool.

The image uses a custom entry point script (`docker-entrypoint.sh`) to generate a AWS IAM token if required.

The Docker image uses the following environment variables to establish a Postgres database connection:

* `PGHOST` - The Postgres host to connect to
* `PGUSER` - The username to use while connecting to Postgres
* `PGDATABASE` - The database to connect to
* `USE_IAM_AUTH` - If set to `1` then an AWS IAM token is generated to use as the password for the connection.
* `PGPASSWORD` - If `USE_IAM_AUTH` is not set `1` then this variable should be set to the password to use for the connection.

## Testing

The `run-test.sh` script will build the Migrations Docker image, start a new Postgres container
and then run the migration scripts against that database. This script should be used to validate that your migration
scripts work before applying them to any AWS environment.
