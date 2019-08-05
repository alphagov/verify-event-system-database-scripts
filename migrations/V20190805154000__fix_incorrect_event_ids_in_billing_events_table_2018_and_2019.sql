UPDATE billing.billing_events be
   SET event_id = ae.event_id,
       transaction_entity_id = ae.details->>'transaction_entity_id'
  FROM audit.audit_events ae
 WHERE be.event_id IN (
	SELECT be1.event_id
	  FROM billing.billing_events be1
	 INNER JOIN audit.audit_events ae1 ON ae1.event_id = be1.event_id
     WHERE be1.time_stamp BETWEEN '2018-01-01' AND '2019-08-01'
	   AND NOT ( ae1.event_type = 'session_event' AND ae1.details ->> 'session_event_type' = 'idp_authn_succeeded' )
 )
 AND be.session_id = ae.session_id
 AND be.time_stamp = ae.time_stamp
 AND ae.event_type = 'session_event'
 AND ae.details->>'session_event_type' = 'idp_authn_succeeded'
;
