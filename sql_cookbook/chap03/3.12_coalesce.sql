
-- coalesce return the first non null value when evaluated
-- it is usefull when working with null values
-- null values usually are not possible to evaluate with anything. null is either null or not null
-- for example if I want to know all employees with comission less then what employee WARD earns, inlcuding the ones that has null commission?


select ename ,comm, coalesce(comm, 0) as non_null_comm from emp 
where coalesce(comm, 0) < (select comm 
                           from emp where ename = 'WARD')