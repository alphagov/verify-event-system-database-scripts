ALTER TABLE audit.audit_event_session_requests OWNER to event_system_owner;
ALTER FUNCTION audit.min_audit_date OWNER to event_system_owner;
ALTER FUNCTION audit.max_audit_date OWNER to event_system_owner;
ALTER FUNCTION audit.fn_inserts_audit_event_session_requests OWNER to event_system_owner;
