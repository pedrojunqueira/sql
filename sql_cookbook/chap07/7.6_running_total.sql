select ename, sal,
    sum(sal) over (order by sal, empno) as running_total
from emp order by 2