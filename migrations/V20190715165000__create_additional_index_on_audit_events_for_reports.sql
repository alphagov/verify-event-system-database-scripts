--
-- Works well with queries, such as those used in the verifications report, that have WHERE
-- clauses constructed as below:
--
-- WHERE ae.event_type = 'session_event'
--   AND ae.time_stamp BETWEEN '2019-06-01 00:00:00.000' AND '2019-06-30 23:59:59.999'
--   AND ae.details->> 'session_event_type' = 'idp_authn_succeeded'
-- ORDER BY ae.time_stamp
--

CREATE INDEX CONCURRENTLY idx_verifications_report
    ON audit.audit_events
 USING btree (time_stamp, (details->> 'session_event_type'))
 WHERE event_type = 'session_event'
;
