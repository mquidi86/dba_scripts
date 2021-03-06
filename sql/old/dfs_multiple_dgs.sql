set feed on
col file# for 9999
col name for a60
col MB for 999,999,999.99
col NEXT_MB for 999,999,999.99
col MAX_MB for 999,999,999.99
col autoextensible for a4
col asm_dg for a25
select tb.ts#,tb.name, count (distinct substr(df.name, 1, instr (df.name,'/',1) ) ) asm_dg_cnt
from 
   v$tablespace tb
   , v$datafile df
where tb.ts#=df.ts#
group by tb.ts#,tb.name --,substr(df.name, 1 , instr (df.name,'/',1) )
having count (distinct substr(df.name, 1, instr (df.name,'/',1) ) ) > 1
order by asm_dg_cnt
;
