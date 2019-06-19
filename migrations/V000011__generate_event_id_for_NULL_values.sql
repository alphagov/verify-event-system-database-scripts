-- For any rows that don't have a matching audit event, generate a random event_id
-- The below UUID formula is used instead of having to install the uuid-ossp extension module
UPDATE billing.billing_events
   SET event_id = uuid_in(overlay(overlay(md5(random()::text || ':' || clock_timestamp()::text) placing '4' from 13) placing to_hex(floor(random()*(11-8+1) + 8)::int)::text from 17)::cstring)
 WHERE event_id IS NULL
;
