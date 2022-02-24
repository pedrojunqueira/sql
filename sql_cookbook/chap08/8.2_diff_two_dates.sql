-- how dateadd works

select c.hiredate, w.hiredate , DATEDIFF(day,c.hiredate, w.hiredate) hire_ate_diff
from

(select 
	hiredate
	from emp
where ename = 'Clark') c,
(
select 
	hiredate
	from emp
where ename = 'Ward') w