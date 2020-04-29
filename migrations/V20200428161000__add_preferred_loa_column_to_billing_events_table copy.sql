ALTER TABLE billing.billing_events
  ADD COLUMN  preferred_level_of_assurance text COLLATE pg_catalog."default" NOT NULL
;
