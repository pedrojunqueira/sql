use [AdventureWorksDW2019] 
go

select * from
(
select 
DepartmentName,
Case when DepartmentName = 'Sales' then BaseRate 
else null end as commision,
Case when DepartmentName != 'Sales' then BaseRate * 40 * 52
else null end as salary
from [dbo].[DimEmployee]) a
order by case when DepartmentName = 'Sales' then commision else salary end