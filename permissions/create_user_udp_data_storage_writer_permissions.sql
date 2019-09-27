GRANT CONNECT ON DATABASE events TO idp_data_storage_writer;

GRANT USAGE ON SCHEMA idp_data TO idp_data_storage_writer;
GRANT USAGE ON SCHEMA billing TO idp_data_storage_writer;
GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA idp_data TO idp_data_storage_writer;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA idp_data TO idp_data_storage_writer;
GRANT SELECT ON billing.fraud_events TO idp_data_storage_writer;
