When I started doing SQL I used to get confused with

`select into` and <br>

`insert into`

the different is that `insert into` is more used to "populate"
an existing table with data.

It can be values or another select query.

For example

with values

```sql
insert into tableName (col1, col2, col3)
values ('value1', 2, 3)
```

with another query

```sql
insert into tableName (col1, col2, col3)
select col1, col2, col3
from anotherTable
```

the data types of the values and queries obviously
should match the data type of the destination table

select into is user to create a new table from a select statement

```sql
select col1, col2, coln
into newTable
from someTable
```

If newTable does not exist it will be creates
and data types will be like the "source" query table

in the `select into newTable` if `newTable` already exist it will
give you an error. In this case you have to use `insert into`

remarks:

Constraints and index of the source table are not
transfered to the newly created table.
