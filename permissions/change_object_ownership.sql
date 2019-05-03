ALTER SCHEMA audit OWNER TO event_system_owner;
ALTER TABLE audit.audit_events OWNER to event_system_owner;
ALTER SCHEMA billing OWNER TO event_system_owner;
ALTER TABLE billing.billing_events OWNER to event_system_owner;
ALTER TABLE billing.fraud_events OWNER to event_system_owner;
