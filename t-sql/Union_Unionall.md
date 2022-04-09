`union` will remove duplicated and `union all` will keep duplicates

```sql
select convert(char(5),'hi') as Greeting
union
select convert(char(11),'hello there') as GreetingNow
union
select convert(char(11),'bonjour')
union
select convert(char(11),'hi')
```

the union will convert to the "bigger" data type to the small fit into the bigger one

```sql
select convert(tinyint, 45) as Mycolumn
union
select convert(bigint, 456)
```

different data types will throw an error

```sql
select 4
union
select 'hi there'
```
