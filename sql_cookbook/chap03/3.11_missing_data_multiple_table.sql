-- full outer join
-- where there are two tables and want in the same query
-- to include allr eacords that are in one and not in another.


--- only left ---


SELECT d.[deptno]
      ,d.[dname]
	  , e.ename
  FROM [dept] d
  left join [emp] e on d.deptno = e.deptno

 --- only right ---

SELECT d.[deptno]
      ,d.[dname]
	  , e.ename
  FROM [dept] d
  right join [emp] e on d.deptno = e.deptno

--- full join ---

SELECT d.[deptno]
      ,d.[dname]
	  , e.ename
  FROM [dept] d
  full join [emp] e on d.deptno = e.deptno

-- insert a row with no dept in emp

--insert into emp (

--       [empno]
--      ,[ename]
--      ,[job]
--      ,[mgr]
--      ,[hiredate]
--      ,[sal]
--      ,[comm]
--      ,[deptno]
--	  )
--select 1111, 'YODA', 'JEDI', null, hiredate, sal, null, null
--from emp
--where ename = 'SMITH'


-- get emp table to original state


delete from emp
where ename = 'YODA'
