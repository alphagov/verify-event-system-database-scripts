DROP TABLE audit.audit_event_session_requests;

CREATE TABLE audit.audit_event_session_requests
(
    session_id           text COLLATE pg_catalog."default" NOT NULL,
    request_id           text COLLATE pg_catalog."default" NOT NULL,
    details              jsonb
);
