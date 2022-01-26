use [AdventureWorksDW2019]

go

select 
FirstName,
DepartmentName
from [dbo].[DimEmployee]
order by SUBSTRING(DepartmentName, len(DepartmentName) -4 ,3) 

-- adventure workds 2019 Db