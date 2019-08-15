ALTER TABLE billing.fraud_events
  ADD COLUMN event_id TEXT COLLATE pg_catalog."default" NULL,
  ADD COLUMN transaction_entity_id TEXT COLLATE pg_catalog."default" NULL
;
