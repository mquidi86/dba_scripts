col TARGET_GUID for a35
col METRIC_COLUMN_GUID for a35
col KEY_VALUE for a60
col VIOLATION_LEVEL for 9999

select *
from SYSMAN.EM_METRIC_ALERTS_LOG
where COLLECTION_TIMESTAMP > trunc(sysdate-1)
/