# verify-event-system-database-scripts

SQL scripts and schemas for the Event System database.

## Migrations

The migrations directory holds the SQL scripts which were used to create the current database. They are used by the
[verify-event-recorder-service](https://github.com/alphagov/verify-event-recorder-service) and the
[verify-billing-reporter](https://github.com/alphagov/verify-billing-reporter) tests.

## Permissions

The permissions directory contains the SQL scripts that were used to create and then later revoke the reader and writer
users. These were replaced by IAM permissions. Only here as a historical reference.
