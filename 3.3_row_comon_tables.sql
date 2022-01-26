--create view vw_Bachelors as
--SELECT
--        CustomerKey
--      , [FirstName]
--      ,[LastName]
--      ,[EnglishEducation]
--       FROM [AdventureWorksDW2019].[dbo].[DimCustomer]
--	   where EnglishEducation = 'Bachelors'

use [AdventureWorksDW2019]

go

select * 
from [dbo].[DimCustomer] c
join [dbo].vw_Bachelors b on
(
    b.CustomerKey = c.CustomerKey and
    b.[FirstName] = c.[FirstName] and
    b.[LastName] = c.[LastName] and
    b.[EnglishEducation] = c.[EnglishEducation]
	)

--drop view vw_Bachelors

select * from vw_Bachelors

-- use intersect

select CustomerKey from [dbo].[DimCustomer]

intersect

select CustomerKey from vw_Bachelors



