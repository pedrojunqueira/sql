Window functions is a way to manipulate how the aggregate or analytical
build in functions behave within a "window" of rows.

This can be done via the user of the `over()` function.

```sql
select A.EmployeeNumber,
       A.AttendanceMonth,
       A.NumberAttendance,
       sum(A.NumberAttendance) over() as TotalAttendance,
       convert(decimal(18,7),A.NumberAttendance) / sum(A.NumberAttendance) over() * 100.0000 as PercentageAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
```

The above query TotalAttendance column will sum the aggregate of all sales for all rows in the
query because no argument was passed in the `over()`

Over can take 3 arguments when used with aggregate functions

`partition`

`order by`

`rows/range`

all of them are optional arguments for aggregate functions

the `partition` argument will define the "window" where the aggregation will
happen.

On the example above if you want the sum the total attendance for each employeeNumber then
it is possible by partitioning it.

```sql
select A.EmployeeNumber, A.AttendanceMonth,
A.NumberAttendance,
sum(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber) as SumAttendance,
```

the `order by` will define how the behavior of the aggregation will be within the
window

if we add `order by` AttendanceMonth then it will be a running total
in the order of Attendance month from top to bottom within the window of the
partition.

this because if there is no `row` or `range` argument after the `order by` the default
behavior will be

`range between unbounded preceding and current row`

```sql
select A.EmployeeNumber, A.AttendanceMonth,
A.NumberAttendance,
SUM(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth RANGE BETWEEN unbounded PRECEDING AND current row ) as RollingTotal,
SUM(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) as RollingTotal2
```

The RollingTotal and RollingTotal2 columns will produce the same result.

Now explaining the `row` and the `range` arguments of `order by`...

The row/range argument will take the key words
`preceding` and `following` to determine the scope within the window for the current row.

`preceding` defines the "from" row on the window to apply the aggregation
`following` defines the "to" row on the window to apply the aggregation

for example

`range between unbounded preceding and unbounded following` will take the full window.

The above example is a bit useless because it will produce the same result of leaving the order by blank
because this is the default behavior.

There are 3 possible scenario to use `range`

    1.range between unbounded preceding and unbounded following
    2.range between unbounded preceding and current row
    3.range between current row and unbounded following

As mentioned previously, there is a better and more efficient alternative to `range` which is the `rows` clause

It is faster and more flexible

The syntax is the same as in `range` but it also accepts the number of rows preceding and following

for example

`rows between 1 preceding and 1 following`

This will have a rolling window that will consider the previous row and the following
row of the row evaluating the aggregation inside the window.

Range and Rows will behave exactly the same with the exception that if there is a
tie in the rows defined in the order by, then `range` will treat ties the same (repeat the value),
however, `rows` will treat differently i.e. the running total will be different for each row.

Besides aggregate functions...

other very useful functions used with `over()` in a window function are "ranking functions"

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
