DO $$ BEGIN
	PERFORM audit.fn_inserts_audit_event_session_requests(begining => '2019-01-01', ending => '2019-06-01');
END $$