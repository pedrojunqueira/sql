
merge into emp2 t
using emp s
on s.empno = t.empno


--When records are matched, update the records if there is any change

when matched and 

t.ename != s.ename or
t.job != s.job or
t.mgr != s.mgr or
t.hiredate != s.hiredate or
t.sal != s.sal or
t.comm != s.comm or 
t.deptno != s.deptno

then update

set 

t.ename = s.ename,
t.job = s.job,
t.mgr = s.mgr, 
t.hiredate = s.hiredate,
t.sal = s.sal,
t.comm = s.comm, 
t.deptno = s.deptno

when not matched by target 

then insert

--When no records are matched, insert the incoming records from source table to target table

(
empno,
ename,
job,
mgr,
hiredate,
sal,
comm,
deptno
)

values

(
s.empno,
s.ename,
s.job,
s.mgr,
s.hiredate,
s.sal,
s.comm,
s.deptno
)

when not matched by source

--When there is a row that exists in target and same record does not exist in source then delete this record target

then delete ;



--$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
--one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row

OUTPUT $action, 

DELETED.ProductID AS TargetProductID, 
DELETED.ProductName AS TargetProductName, 
DELETED.Rate AS TargetRate, 
INSERTED.ProductID AS SourceProductID, 
INSERTED.ProductName AS SourceProductName, 
INSERTED.Rate AS SourceRate; 

SELECT @@ROWCOUNT;
GO
