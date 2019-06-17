GRANT CONNECT ON DATABASE events TO billing_status_calculator;
GRANT USAGE ON SCHEMA billing TO billing_status_calculator;
GRANT SELECT ON billing.billing_events TO billing_status_calculator;
GRANT SELECT, INSERT, UPDATE ON billing.billing_status TO billing_status_calculator;
