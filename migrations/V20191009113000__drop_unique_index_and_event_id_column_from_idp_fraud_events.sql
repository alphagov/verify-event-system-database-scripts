ALTER TABLE idp_data.idp_fraud_events
  DROP COLUMN event_id
;
DROP INDEX idp_data.idp_fraud_events_idp_entity_id_idp_event_id_idx;
