ALTER TABLE billing.billing_events
  ADD COLUMN transaction_entity_id TEXT COLLATE pg_catalog."default" NULL
;
