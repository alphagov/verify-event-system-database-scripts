CREATE OR REPLACE FUNCTION audit.max_audit_date() RETURNS varchar LANGUAGE SQL AS
$$
SELECT cast(MAX(time_stamp) as varchar) FROM audit.audit_events;
$$;