UPDATE billing.billing_events be
   SET be.event_id = ae.event_id
  FROM audit.audit_events ae
 WHERE be.event_id IS NULL
   AND ae.session_id = be.session_id
   AND ae.time_stamp = be.time_stamp
;

