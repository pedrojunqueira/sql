
select 

sum(distinct sal) as total_sal,
sum(bonus) as total_bonus

from (

select e.empno,
       e.ename,
	   e.sal,
	   e.deptno,
	   e.sal * case when eb.type = 1 then .1
	                when eb.type = 2 then .2 
					else .3
					end as bonus
from emp e
join emp_bonus eb
on e.empno = eb.empno
where e.deptno = 10

) ag

group by deptno

-- employee has 2 bonuses. Bonus is ok but salary will double count
-- slolution is to use sum distinct