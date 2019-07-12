CREATE INDEX CONCURRENTLY ON billing.billing_events USING btree (hashed_persistent_id, time_stamp);
