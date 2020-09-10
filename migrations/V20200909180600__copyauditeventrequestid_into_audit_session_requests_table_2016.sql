DO $$ BEGIN
	PERFORM audit.fn_inserts_audit_event_session_requests(begining => '2016-01-01', ending => '2017-01-01');
END $$