
CREATE OR REPLACE FUNCTION audit.fn_inserts_audit_event_session_requests
(
	begining character varying DEFAULT audit.min_audit_date(),
	ending character varying DEFAULT audit.max_audit_date()
)
RETURNS void
LANGUAGE 'plpgsql'
AS
$BODY$
BEGIN
	INSERT INTO audit.audit_event_session_requests
	SELECT
	source.session_id AS session_id,
	source.request_id AS request_id
	FROM
	(
		SELECT session_id,
		CASE
			WHEN details ? 'request_id' THEN details ->> 'request_id'
			WHEN details ? 'message_id' THEN details ->> 'message_id'
		END AS request_id
		FROM
		(
			SELECT session_id, details FROM audit.audit_events
			WHERE time_stamp >= TO_DATE(begining, 'YYYY-MM-DD')
			AND time_stamp < TO_DATE(ending, 'YYYY-MM-DD')
		)
		AS filtered_audits
		WHERE details ? 'request_id' OR details ? 'message_id'
		GROUP BY session_id, request_id
	)
	AS source
	LEFT JOIN audit.audit_event_session_requests AS destination
	ON source.session_id = destination.session_id
	AND source.request_id = destination.request_id
  WHERE destination.session_id IS NULL AND destination.request_id IS NULL;
END;
$BODY$;
