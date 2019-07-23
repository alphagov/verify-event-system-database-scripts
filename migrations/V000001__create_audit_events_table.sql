CREATE SCHEMA audit AUTHORIZATION event_system_owner;

CREATE TABLE audit.audit_events
(
    event_id             text COLLATE pg_catalog."default" NOT NULL,
    time_stamp           timestamp                         NOT NULL,
    originating_service  text COLLATE pg_catalog."default" NOT NULL,
    session_id           text COLLATE pg_catalog."default",
    event_type           text COLLATE pg_catalog."default" NOT NULL,
    details              jsonb,
    PRIMARY KEY (event_id, time_stamp)
)
TABLESPACE pg_default;
ALTER TABLE audit.audit_events OWNER to event_system_owner;
CREATE INDEX audit_events_time_stamp_idx ON audit.audit_events (time_stamp);
