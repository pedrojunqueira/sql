with iter(V) as (

select 1
union all 
select V + 1  from iter
where V < 10

),
string_to_iter as (

select ename
from emp
where ename = 'King'

)

select i.V, SUBSTRING(ename, i.V, 1 ) 
from string_to_iter s
cross join iter i
where i.V <= len(s.ename)