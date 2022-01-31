--- use records from another table to update a table
-- say there is a emp_new_salary for a dep and you want to update
-- the salaries on emp table

-- create new_sal record

select 10 as deptno, 4000 as sal 
into new_sal

-- update records on emp2

update emp2 
set sal = ns.sal,
    comm = ns.sal/2

from new_sal ns
join emp2 e
on ns.deptno = e.deptno
