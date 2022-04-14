Functions in SQL is a good idea to encapsulate code
that can be a mean of avoid receding code and also
improve performance if used in a column or
as a table expression

There are basically 3 type of functions to be
created

    1. Scalar Functions

```sql

CREATE FUNCTION dbo.AmountPlusOne(@Amount smallmoney)
RETURNS smallmoney
AS
BEGIN

    RETURN @Amount + 1

END
GO
```

Then you can just user

`select dbo.AmountPlusOne(1)`

    2. Inline Table Function

```sql
    CREATE FUNCTION TransactionList(@EmployeeNumber int)
RETURNS TABLE AS RETURN
(
    SELECT * FROM tblTransaction
    WHERE EmployeeNumber = @EmployeeNumber
)

```

then can be called in the `from`
clause

```sql
select * from
TransactionList(33)
```

or in a Join with `apply` operator

```sql
select *
from employee e
cross apply TransactionList(e.employeeId)
```

T-SQL microsoft docs [CREATE FUNCTION](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-function-transact-sql?view=sql-server-ver15)
