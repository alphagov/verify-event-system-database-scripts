UPDATE billing.fraud_events fe
   SET event_id = ae.event_id,
       transaction_entity_id = ae.details ->> 'transaction_entity_id'
  FROM audit.audit_events ae
 WHERE ae.session_id = fe.session_id
   AND ae.time_stamp = fe.time_stamp
   AND ae.event_type = 'session_event'
   AND ae.details ->> 'session_event_type' = 'fraud_detected'
   AND fe.event_id IS NULL
;
