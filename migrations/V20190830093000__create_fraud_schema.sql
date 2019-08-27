CREATE SCHEMA idp_data AUTHORIZATION event_system_owner;

CREATE TABLE idp_data.upload_sessions
(
    id                      BIGSERIAL,
    time_stamp              TIMESTAMP NOT NULL,
    source_file_name        TEXT COLLATE pg_catalog."default" NOT NULL,
    idp_entity_id           TEXT COLLATE pg_catalog."default" NOT NULL,
    userid                  TEXT COLLATE pg_catalog."default" NOT NULL,
    passed_validation       BOOLEAN NOT NULL,
    PRIMARY KEY (id)
)
TABLESPACE pg_default;
ALTER TABLE idp_data.upload_sessions OWNER to event_system_owner;

CREATE TABLE idp_data.upload_session_validation_failures
(
    id                      BIGSERIAL,
    upload_session_id       BIGINT NOT NULL,
    row                     BIGINT NOT NULL,
    field                   TEXT COLLATE pg_catalog."default" NOT NULL,
    message                 TEXT COLLATE pg_catalog."default" NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT upload_session_validation_failures_upload_session_id_fkey FOREIGN KEY (upload_session_id) REFERENCES idp_data.upload_sessions(id)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
)
TABLESPACE pg_default;
ALTER TABLE idp_data.upload_session_validation_failures OWNER to event_system_owner;

CREATE TABLE idp_data.idp_fraud_events
(
    id                      BIGSERIAL,
    idp_entity_id           TEXT COLLATE pg_catalog."default" NOT NULL,
    idp_event_id            TEXT COLLATE pg_catalog."default" NOT NULL,
    time_stamp              TIMESTAMP NOT NULL,
    fid_code                TEXT COLLATE pg_catalog."default" NOT NULL,
    request_id              TEXT COLLATE pg_catalog."default" NOT NULL,
    pid                     TEXT COLLATE pg_catalog."default" NOT NULL,
    client_ip_address       TEXT COLLATE pg_catalog."default" NOT NULL,
    contra_score            INT NOT NULL,
    event_id                TEXT COLLATE pg_catalog."default" NULL,
    upload_session_id       BIGINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT idp_fraud_events_event_id_fkey FOREIGN KEY (event_id) REFERENCES billing.fraud_events(event_id)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT,
    CONSTRAINT idp_fraud_events_upload_session_id_fkey FOREIGN KEY (upload_session_id) REFERENCES idp_data.upload_sessions(id)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
)
TABLESPACE pg_default;
ALTER TABLE idp_data.idp_fraud_events OWNER to event_system_owner;

CREATE UNIQUE INDEX idp_fraud_events_idp_entity_id_idp_event_id_idx ON idp_data.idp_fraud_events(idp_entity_id, idp_event_id);

CREATE TABLE idp_data.idp_fraud_event_contraindicators
(
    idp_fraud_events_id     BIGINT,
    contraindicator_code    TEXT COLLATE pg_catalog."default" NOT NULL,
    PRIMARY KEY (idp_fraud_events_id, contraindicator_code),
    CONSTRAINT idp_fraud_event_contraindicators_idp_fraud_events_id_fkey FOREIGN KEY (idp_fraud_events_id) REFERENCES idp_data.idp_fraud_events(id)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
)
TABLESPACE pg_default;
ALTER TABLE idp_data.idp_fraud_event_contraindicators OWNER to event_system_owner;
