with sum_sal as (

select distinct 
deptno
, sum(sal) over() as ttlsal
, sum(sal) over(partition by deptno) as depsal
from emp
)

select depsal/ttlsal perc_sal_ttl
from sum_sal

-- percentage salary of total