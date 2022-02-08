select FORMATMESSAGE('count(1) from %s', table_name)
from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA = 'dbo'


---------------------------

select 'insert into table_name ( empno, ename, mgr, hiredate, sal, comm, deptno )' 

+ FORMATMESSAGE('    values (%d )', empno )
from emp where empno = 7369


