ALTER TABLE billing.fraud_events
  ALTER COLUMN event_id SET NOT NULL,
  ALTER COLUMN transaction_entity_id SET NOT NULL
;
ALTER TABLE billing.fraud_events ADD CONSTRAINT fraud_events_pkey PRIMARY KEY(event_id);
