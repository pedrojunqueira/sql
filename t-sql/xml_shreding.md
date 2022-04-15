XML shredding is the process of transforming an
well formed XML document into a sql table structured object.

there are useful methods in t-sql to perform shredding

the `query()` is useful as it return the children of the document
been queried

`query ('XQuery')`

`XQuery` is the query that traverses the XML tree

The query of the document below it navigates to the item node

to navigate element nodes use `/` forward slash
to refer to XML element attributes value use the `@` followed by attribute name
to access element in the array use `[]` square bracket.

```sql
declare @x xml
set @x='<Shopping ShopperName="Phillip Burton" >
<ShoppingTrip ShoppingTripID="L1" >
  <Item Cost="5">Bananas</Item>
  <Item Cost="4">Apples</Item>
  <Item Cost="3">Cherries</Item>
</ShoppingTrip>
<ShoppingTrip ShoppingTripID="L2" >
  <Item>Emeralds</Item>
  <Item>Diamonds</Item>
  <Item>Furniture</Item>
</ShoppingTrip>
</Shopping>'
select @x.query('/Shopping/ShoppingTrip/Item')
```

however the query allow iteration in the document

it follow the FLWOR structure in this order where

F = for
L = let
W = where
O = order
r = return

```sql
declare @x xml
set @x='<Shopping ShopperName="Phillip Burton" >
<ShoppingTrip ShoppingTripID="L1" >
  <Item Cost="5">Bananas</Item>
  <Item Cost="4">Apples</Item>
  <Item Cost="3">Cherries</Item>
</ShoppingTrip>
<ShoppingTrip ShoppingTripID="L2" >
  <Item>Emeralds</Item>
  <Item>Diamonds</Item>
  <Item>Furniture</Item>
</ShoppingTrip>
</Shopping>'
select @x.query('for $ValueRetrieved in /Shopping/ShoppingTrip/Item
                 return $ValueRetrieved')
```

in the case above will return the same but will have the return
in the $ValueRetrieved variable

for example we can return just the string of the element

```sql
select @x.query('for $ValueRetrieved in /Shopping/ShoppingTrip/Item
                 return string($ValueRetrieved'))
```

or concat strings returned with `;` semi-colons

```sql
select @x.query('for $ValueRetrieved in /Shopping/ShoppingTrip[1]/Item
                 return concat(string($ValueRetrieved),";")')
```

then the below example is how sophisticated
FLWOR can get

```sql
select @x.query('for $ValueRetrieved in /Shopping/ShoppingTrip[1]/Item
                 let $CostVariable := $ValueRetrieved/@Cost
                 where $CostVariable >= 4
                 order by $CostVariable
                 return concat(string($ValueRetrieved),";")')
```

it assign the iterated item to a variable using the let
then filters with a where clause then then return.

another useful is the value method

the `value` method takes 2 arguments

```sql
value (XQuery, SQLType)
```

```sql
select @x.value('(/Shopping/ShoppingTrip/Item/@Cost)[1]','varchar(50)')
```

`SQLType` is the return type of the query result.

in the example above it returns
value 5 which is the value in the query

another useful method is `exist()`

takes one argument `XQuery`

return 1 if result is not null and 0 if null

The nodes() method is useful when you want to shred an xml data type instance into relational data. It allows you to identify nodes that will be mapped into a new row

here is the syntax

`nodes (XQuery) as Table(Column)`

here is an example and the return

```sql
select tbl.col.value('.', 'varchar(50)') as Item
     , tbl.col.value('@Cost','varchar(50)') as Cost

from @x.nodes('/Shopping/ShoppingTrip/Item') as tbl(col)
```

this will return the following table rows.

| Item      | Cost |
| --------- | ---- |
| Bananas   | 5    |
| Apples    | 4    |
| Cherries  | 3    |
| Emeralds  | NULL |
| Diamonds  | NULL |
| Furniture | NULL |

Now most of the real life example will be something like
this

```sql

declare @x1 xml, @x2 xml , @x3 xml
set @x1='<Shopping ShopperName="Phillip Burton" >
<ShoppingTrip ShoppingTripID="L1" >
  <Item Cost="5">Bananas</Item>
  <Item Cost="4">Apples</Item>
  <Item Cost="3">Cherries</Item>
</ShoppingTrip></Shopping>'
set @x2='<Shopping ShopperName="Phillip Burton" >
<ShoppingTrip ShoppingTripID="L2" >
  <Item>Emeralds</Item>
  <Item>Diamonds</Item>
  <Item>Furniture</Item>
</ShoppingTrip>
</Shopping>'

set @x3='<Shopping ShopperName="Pedro Junqueira" >
<ShoppingTrip ShoppingTripID="L2" >
  <Item Cost="44">Bicycle</Item>
  <Item Cost="1">Croisants</Item>
  <Item Cost="0.3">Coffee</Item>
</ShoppingTrip>
</Shopping>'


create table #tblXML(pkXML INT PRIMARY KEY, xmlCol XML)

insert into #tblXML(pkXML, xmlCol) VALUES (1, @x1)
insert into #tblXML(pkXML, xmlCol) VALUES (2, @x2)
insert into #tblXML(pkXML, xmlCol) VALUES (3, @x3)


select * from #tblXML

select
  sourceTable.pkXML
,tbl.col.value('@Cost','varchar(50)') as cost
, tbl.col.value('.','varchar(50)') as itemName
from #tblXML sourceTable
CROSS APPLY
xmlCol.nodes('/Shopping/ShoppingTrip/Item') as tbl(col)

drop table #tblXML

```

usually there will be a table with a xml document per row
then it is possible to
`cross apply` for each row the nodes() method for each row
which will return a table that can be joined with the
source table

this will return

| pkXML | cost | itemName  |
| ----- | ---- | --------- |
| 1     | 5    | Bananas   |
| 1     | 4    | Apples    |
| 1     | 3    | Cherries  |
| 2     | NULL | Emeralds  |
| 2     | NULL | Diamonds  |
| 2     | NULL | Furniture |
| 3     | 44   | Bicycle   |
| 3     | 1    | Croisants |
| 3     | 0.3  | Coffee    |
