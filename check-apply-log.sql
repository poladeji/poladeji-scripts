--How to find out backlog of standby

select round((sysdate - a.NEXT_TIME)*24*60) as "Backlog",m.SEQUENCE#-1 "Seq Applied",m.process, m.status 
from v$archived_log a, (select process,SEQUENCE#, status from v$managed_standby where process like '%MRP%')m where a.SEQUENCE#=(m.SEQUENCE#-1);

set line 100
column time_computed format a25;
col LAG_TIME for a15;
col DATUM_TIME for a20;
col DB_UNIQUE_NAME for a15;
col open_mode for a20
col name for a13
col value for a13
col unit for a30
set lines 132
select NAME, DB_UNIQUE_NAME, DATABASE_ROLE, open_mode from v$database;
--SELECT NAME, VALUE LAG_TIME, DATUM_TIME, TIME_COMPUTED from V$DATAGUARD_STATS where name like 'apply lag';
select name, value, unit, time_computed from v$dataguard_stats where name in ('transport lag', 'apply lag');

