DO $$ BEGIN
	PERFORM audit.fn_inserts_audit_event_session_requests(ending => '2016-01-01');
END $$