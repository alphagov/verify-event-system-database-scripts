CREATE ROLE event_system_owner;
GRANT CREATE ON DATABASE events TO event_system_owner;
CREATE ROLE dbmigrator LOGIN PASSWORD 'password' INHERIT IN ROLE event_system_owner;

