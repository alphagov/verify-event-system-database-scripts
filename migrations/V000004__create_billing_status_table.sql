CREATE TABLE billing.billing_status
(
    event_id        TEXT COLLATE pg_catalog."default" NOT NULL,
    billing_status  TEXT COLLATE pg_catalog."default" NOT NULL,
    PRIMARY KEY (event_id)
)
TABLESPACE pg_default;
ALTER TABLE billing.billing_status OWNER TO event_system_owner;
