CREATE INDEX audit_events_event_id_idx1 ON audit.audit_events (event_id);
CREATE INDEX billing_events_session_id_idx1 ON billing.billing_events (session_id);
CREATE INDEX fraud_events_session_id_idx ON billing.fraud_events (session_id);
