use Play

go

select deptno, STRING_AGG( ename, ', ') WITHIN GROUP (ORDER BY ename ASC)  as csv 
from emp
group by deptno