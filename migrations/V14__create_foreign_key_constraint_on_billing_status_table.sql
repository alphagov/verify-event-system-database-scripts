ALTER TABLE billing.billing_status
  ADD CONSTRAINT event_id_fkey FOREIGN KEY (event_id) REFERENCES billing.billing_events(event_id)
   ON DELETE RESTRICT
   ON UPDATE CASCADE
;
