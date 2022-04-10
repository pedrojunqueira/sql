Window functions happens ate the row level
and is used with the over() clause

```sql
select A.EmployeeNumber,
       A.AttendanceMonth,
       A.NumberAttendance,
       sum(A.NumberAttendance) over() as TotalAttendance,
       convert(decimal(18,7),A.NumberAttendance) / sum(A.NumberAttendance) over() * 100.0000 as PercentageAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
```

the above query TotalAttendance will sum (aggregate all sales for all rows)

Over can take 3 arguments in aggregate functions

`partition`

`order by`

`rows/range`

all of them are option arguments for aggregate functions

the `partition` argument will define the "window" where the aggregation will
happen.

On the example above it want the sum for each employeeNumber then
it is possible to partition it.

```sql
select A.EmployeeNumber, A.AttendanceMonth,
A.NumberAttendance,
sum(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber) as SumAttendance,
```

the order by will define how the behavior of the aggregation will be within the
window

if added order by AttendanceMonth then it will be a running total
each row in the order of Attendance month from top to bottom within the window of the
partition.

this because if there is no row or range argument the default will be

`range between unbounded preceding and current row`

```sql
select A.EmployeeNumber, A.AttendanceMonth,
A.NumberAttendance,
SUM(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth RANGE BETWEEN unbounded PRECEDING AND current row ) as RollingTotal,
SUM(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) as RollingTotal2
```

RollingTotal and RollingTotal2 will produce the same result.

the row argument will take
preceding and following in the range

preceding is the "from" row on the window to apply the aggregation
following is the "to" row on the window to apply the aggregation

for example

`range between unbounded preceding and unbounded following` will take the full window.

this does not make sense but and will produce the same result of leaving the order by blank
because this is the default behavior for the partition aggregation.

Therefore there are 3 possible scenario to use `range`

    1.`range between unbounded preceding and unbounded following`
    2.`range between unbounded preceding and current row`
    3.`range between current row and unbounded following`

There is better and more efficient alternative to range which is the `rows` clause

it is faster and more flexible

the syntax is the same but it accepts the number of rows preceding and following

for example

`rows between 1 preceding and 1 following`

this will have a rolling window that will consider the previous row and the following
row in given the order by parameter.

Range and Rows will behave exactly the same with the exertion that if there is a
tie in the order by `range` will treat ties the same (repeat the value) and
rows will treat differently i.e. the running total will be different for each row.

Apart from aggregate functions

very useful functions used with `over()` in a window function are "ranking functions"

`rank()`
`dense_rank()`
`row_number()`

Those works with `over()`, however the order by argument is compulsory and the partition is optional.

The range and rows are not applicable.

The difference is that

row_number will treat ties differently. It will never repeat values.
rank will give the same value in a tie and the next in the sequence will be the next number in the series
dense_rank works like golf PGA Tour ranking. If there is a tie it repeats the order then skip to the
next rank counting the number of times the ties happened.

Other analytical functions can be used as window functions.

The most useful ones are

`lag()`
`lead()`
`first_value()`
`last_value()`
