UPDATE billing.billing_events be
   SET event_id = ae.event_id
  FROM audit.audit_events ae
 WHERE be.time_stamp >= '2018-01-01' AND be.time_stamp < '2019-01-01'
   AND be.event_id IS NULL
   AND ae.session_id = be.session_id
   AND ae.time_stamp = be.time_stamp
;
