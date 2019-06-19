ALTER TABLE billing.billing_events ALTER COLUMN event_id SET NOT NULL;
ALTER TABLE billing.billing_events ADD PRIMARY KEY USING INDEX billing_events_pkey;
