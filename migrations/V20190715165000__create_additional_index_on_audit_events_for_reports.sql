CREATE INDEX CONCURRENTLY ON audit.audit_events USING btree ((details->> 'session_event_type'), time_stamp)
 WHERE event_type = 'session_event';
