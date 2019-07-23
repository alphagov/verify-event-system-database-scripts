CREATE SCHEMA billing AUTHORIZATION event_system_owner;

CREATE TABLE billing.billing_events
(
    time_stamp                   timestamp                         NOT NULL,
    session_id                   text COLLATE pg_catalog."default" NOT NULL,
    hashed_persistent_id         text COLLATE pg_catalog."default" NOT NULL,
    request_id                   text COLLATE pg_catalog."default" NOT NULL,
    idp_entity_id                text COLLATE pg_catalog."default" NOT NULL,
    minimum_level_of_assurance   text COLLATE pg_catalog."default" NOT NULL,
    required_level_of_assurance  text COLLATE pg_catalog."default" NOT NULL,
    provided_level_of_assurance  text COLLATE pg_catalog."default" NOT NULL
)
TABLESPACE pg_default;
ALTER TABLE billing.billing_events OWNER to event_system_owner;
CREATE INDEX billing_events_time_stamp_idx ON billing.billing_events (time_stamp);
CREATE INDEX billing_events_hashed_persistent_id_idx ON billing.billing_events (hashed_persistent_id);
CREATE INDEX billing_events_provided_level_of_assurance_idx ON billing.billing_events (provided_level_of_assurance);

CREATE TABLE billing.fraud_events
(
    time_stamp            timestamp                         NOT NULL,
    session_id            text COLLATE pg_catalog."default" NOT NULL,
    hashed_persistent_id  text COLLATE pg_catalog."default" NOT NULL,
    request_id            text COLLATE pg_catalog."default",
    entity_id             text COLLATE pg_catalog."default" NOT NULL,
    fraud_event_id        text COLLATE pg_catalog."default" NOT NULL,
    fraud_indicator       text COLLATE pg_catalog."default" NOT NULL
)
TABLESPACE pg_default;
ALTER TABLE billing.fraud_events OWNER to event_system_owner;
CREATE INDEX fraud_events_time_stamp_idx ON billing.fraud_events (time_stamp);
CREATE INDEX fraud_events_hashed_persistent_id_idx ON billing.fraud_events (hashed_persistent_id);
