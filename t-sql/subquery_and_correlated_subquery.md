1. on `select`

```sql
Select *, (select count(EmployeeNumber)
           from tblTransaction as T
		   where T.EmployeeNumber = E.EmployeeNumber) as NumTransactions,
		  (Select sum(Amount)
		   from tblTransaction as T
		   where T.EmployeeNumber = E.EmployeeNumber) as TotalAmount
from tblEmployee as E
Where E.EmployeeLastName like 'y%'

```

2. on 'where`

```sql
select *
from tblTransaction as T
Where exists
    (Select EmployeeNumber from tblEmployee as E where EmployeeLastName like 'y%' and T.EmployeeNumber = E.EmployeeNumber)
order by EmployeeNumber
```

3. on `from` for top X

```sql
select * from
(select D.Department, EmployeeNumber, EmployeeFirstName, EmployeeLastName,
       rank() over(partition by D.Department order by E.EmployeeNumber) as TheRank
 from tblDepartment as D
 join tblEmployee as E on D.Department = E.Department) as MyTable
where TheRank <= 5

```

another way to get it if to use the `apply`

```sql
select * from
tblEmployee E
cross apply (
select top (5)  D.Department, EmployeeNumber, EmployeeFirstName, EmployeeLastName
from from tblDepartment as D
where  E on D.Department = E.Department
)MyTable

```
