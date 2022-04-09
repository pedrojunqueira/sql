Case is like works like a if then.
It will evaluate the test for true/false and return
the first instance it is true.

the else is optional and will be a "catch all"
in case none of the when test evaluates to true.

If there is no else and no when is true then it returns 'NULL`

```sql
declare @myOption as varchar(10) = 'Option C'

select case when @myOption = 'Option A' then 'First option'
            when @myOption = 'Option B' then 'Second option'
			else 'No Option'
			END as MyOptions
go
```

There is another easier way for the syntax is only one value is evaluates

```sql
declare @myOption as varchar(10) = 'Option C'

select case @myOption
			when 'Option A' then 'First option'
            when 'Option B' then 'Second option'
			else 'No Option'
			END as MyOptions
go
```

the latter is shorter but less flexible.
