GRANT CONNECT ON DATABASE events TO idp_data_storage_writer;

GRANT USAGE ON SCHEMA idp_data TO idp_data_storage_writer;
GRANT USAGE ON SCHEMA billing TO idp_data_storage_writer;
GRANT SELECT, INSERT, DELETE ON idp_data.* TO idp_data_storage_writer;
GRANT SELECT ON billing.fraud_events TO idp_data_storage_writer;
