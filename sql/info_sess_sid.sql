define sid=&1
set pages 200
set lines 185
col sess for a10
col event for a27
col sql_id for a13
col remaining for a20 trunc
col object for a35 trunc
col subobject_name for a18 trunc
col comp for 99.99
col temp_mb for 99,999
col status for a20
col username for a20 truncated
col spid for a10
set trims on
select s.sid||','||s.serial# sess
,p.spid,s.username 
, OSUSER
, MACHINE
, type
, sql.sql_id
, SCHEMANAME
, s.status
from v$session s
  ,(select * from v$session_longops where sofar < totalwork) slo
  ,(select session_addr,sum(blocks*block_size) temp_bytes
      from v$sort_usage, dba_tablespaces 
      where tablespace=tablespace_name
      group by session_addr,tablespace_name) su
  ,v$process p
  ,v$sql sql
  ,dba_objects o
where 
  s.sql_id=sql.sql_id (+)
  and s.sql_child_number=sql.child_number (+)
  and s.sid=slo.sid (+)
  and s.row_wait_obj#=o.object_id (+)
  and s.saddr=su.session_addr (+)
  and s.paddr=p.addr
  and s.sid=&sid
/
