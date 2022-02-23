-- how dateadd works

select 
	hiredate
	, DATEADD(DAY, -5, hiredate) h_minus_5_days
	, DATEADD(DAY,  5, hiredate) h_plus_5_days
	, DATEADD(MONTH, -5, hiredate) h_minus_5_months
	, DATEADD(Year, -5, hiredate) h_minus_5_years
from emp
where ename = 'Clark'