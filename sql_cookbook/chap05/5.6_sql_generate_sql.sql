select FORMATMESSAGE('count(1) from %s', table_name)
from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA = 'dbo'


---------------------------
-- populate a copy of the data of a table --

select 'insert into emp ( empno, ename, mgr, hiredate, sal, comm, deptno )' ,
FORMATMESSAGE('values (%s, ''%s'', %s, ''%s'', %s, %s, %s)'
, coalesce (cast(empno as varchar), 'NULL')
, coalesce (ename, 'NULL')
, coalesce( cast(mgr as varchar), 'NULL')
, coalesce( cast(hiredate as varchar), 'NULL')
, coalesce (cast(sal as varchar), 'NULL')
, coalesce (cast(comm as varchar), 'NULL')
, coalesce( cast(deptno as varchar), 'NULL')
)

from emp 

