the concept of recursive in programing
is when a function call itself.

The way it works in sql with CTE a pattern needs to happen.

1. Anchor query
2. a Recursive query followed by the `union all` operator
3. a termination condition which will stop the iteration.

```sql
WITH expression_name (column_list)
AS
(
    -- Anchor member
    initial_query
    UNION ALL
    -- Recursive member that references expression_name.
    recursive_query
)
-- references expression name
SELECT *
FROM   expression_name
```

[good article about recursive CTE](https://www.sqlservertutorial.net/sql-server-basics/sql-server-recursive-cte/)

here is the example of the article

```sql
WITH cte_numbers(n, weekday)
AS (
    SELECT
        0,
        DATENAME(DW, 0)
    UNION ALL
    SELECT
        n + 1,
        DATENAME(DW, n + 1)
    FROM
        cte_numbers
    WHERE n < 6
)
SELECT
    weekday
FROM
    cte_numbers;
```

this query will return the name of all weekdays from Monday to Sunday
