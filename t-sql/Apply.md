probably one of the most unknown and powerful
weapon in SQL is the `apply` operator

`apply` operator can be user in a right part of the join
providing it is a table expression or a table values function.

It behaves like a normal join

for example

```sql
select *
from table1 t1
inner join table t2
    on t1.id = t.2id
```

would be

```sql
select *
from table1 t1
cross apply
    ( select *
    from table2 t2
    where t2.id = t1.id
    ) A
```

`apply` can be

`cross apply` equivalent to inner join <br>
or
`outer apply` equivalent to outer join

what `cross apply` does it is like an "iterator" where every
matching row in the left table will evaluate the
right expression and return the matching rows.

If `cross` version is used then the no matching rows will be
suppressed.

this [article](https://www.mssqltips.com/sqlservertip/1958/sql-server-cross-apply-and-outer-apply/)

gives a good explanation.
