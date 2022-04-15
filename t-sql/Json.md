Json is simpler than xml and
T-SQL helps a lot

here is the function reference [docs](https://docs.microsoft.com/en-us/sql/t-sql/functions/json-functions-transact-sql?view=sql-server-ver15)

```sql
declare @json NVARCHAR(4000)SET @json = '
{"name" : "Pedro",
"Activity":
{"Type": "BikeRide",
"Items":
[
{"Item":"Coffee", "Cost":5},
{"Item":"Croissant", "Cost":4}
]
}}
'
```

it can just be stored in a string `nvarchar`

once you have access to the json document then here are the methods to
turn into sql structure

`isjson()`

check if document is a valid JSON document

`JSON_VALUE`

syntax

`JSON_VALUE ( expression , path )`

select JSON_value(@json,'$."name"')

note that the json key are case sensitive

it is possible to traverse the structure by using `.` dots and then
`[]` square brackets to get array elements

`select json_value(@json,'strict $.Activity.Items[1].Item')`

`JSON_MODIFY`

`select json_modify(@json,'strict $.Activity.Items[1].Item','Milk')`

`JSON_QUERY`

this will return either an object or an array if existing in the node
otherwise will return null

so

`select JSON_QUERY(@json,'$.Activity')`

will return

`{"BikeRide": "L1", "Items": [ {"Item":"Coffee", "Cost":5}, {"Item":"Croissant", "Cost":4} ] }`

and

`select JSON_QUERY(@json,'$.Activity.Items')`

will return

`[ {"Item":"Coffee", "Cost":5}, {"Item":"Croissant", "Cost":4} ]`

and

`select JSON_QUERY(@json,'$.Activity.Items[0].Cost')`

will return

`NULL`

Finally the [openjson](https://docs.microsoft.com/en-us/sql/t-sql/functions/openjson-transact-sql?view=sql-server-ver15)

OPENJSON is a table-valued function that parses JSON text and returns objects and properties from the JSON input as rows and columns. In other words, OPENJSON provides a rowset view over a JSON document. You can explicitly specify the columns in the rowset and the JSON property paths used to populate the columns. Since OPENJSON returns a set of rows, you can use OPENJSON in the FROM clause of a Transact-SQL statement just as you can use any other table, view, or table-valued function.

```sql
select * from openjson(@json)`
```

this returns

| key      | value                                                                                           | type |
| -------- | ----------------------------------------------------------------------------------------------- | ---- |
| name     | Pedro                                                                                           | 1    |
| Activity | {"Type": "BikeRide", "Items": [ {"Item":"Coffee", "Cost":5}, {"Item":"Croissant", "Cost":4} ] } | 5    |

And

```sql
select * from openjson(@json,'$.Activity.Items')
	with (Item varchar(20), Cost int)
```

this returns

| Item      | Cost |
| --------- | ---- |
| Coffee    | 5    |
| Croissant | 4    |

now finally more of
a real world example with cross apply consuming
Json content from multiple rows

```sql

declare @json1 NVARCHAR(4000)SET @json1 = '
{"name" : "Pedro",
"Activity":
{"Type": "BikeRide",
"Items":
[
{"Item":"Coffee", "Cost":5},
{"Item":"Croissant", "Cost":4}
]
}}
'
declare @json2 NVARCHAR(4000)SET @json2 = '
{"name" : "Jone",
"Activity":
{"Type": "BikeRide",
"Items":
[
{"Item":"Milk", "Cost":5},
{"Item":"Brownie", "Cost":11}
]
}}
'


create table jsonTable
( docID int null,
  JsonDoc nvarchar(4000))



insert into jsonTable
values (1, @json1),
       (2, @json2)

select jrows.docID, jshredded.item, jshredded.cost from
jsonTable jrows
cross apply openjson(jrows.JsonDoc,'$.Activity.Items')
	with (Item varchar(20), Cost int) jshredded

drop table jsonTable
```

this returns

| docID | Item      | Cost |
| ----- | --------- | ---- |
| 1     | Coffee    | 5    |
| 1     | Croissant | 4    |
| 2     | Milk      | 5    |
| 2     | Brownie   | 11   |
