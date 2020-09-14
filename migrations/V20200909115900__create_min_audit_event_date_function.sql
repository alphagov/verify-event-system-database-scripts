CREATE OR REPLACE FUNCTION audit.min_audit_date() RETURNS varchar LANGUAGE SQL AS
$$
SELECT cast(MIN(time_stamp) as varchar) FROM audit.audit_events;
$$;


