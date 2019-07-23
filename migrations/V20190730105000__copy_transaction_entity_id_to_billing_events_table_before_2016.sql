UPDATE billing.billing_events be
   SET transaction_entity_id = ae.details ->> 'transaction_entity_id'
  FROM audit.audit_events ae
 WHERE be.time_stamp < '2016-01-01'
   AND be.transaction_entity_id IS NULL
   AND ae.event_id = be.event_id
;
