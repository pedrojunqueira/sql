
---- table preparation

-- create view v as
--    select [BusinessEntityID]
--       ,[PersonType]
--       ,[NameStyle]
--       ,[FirstName]
--       ,[LastName]
--       ,[EmailPromotion]
--       ,[ModifiedDate]
--   from person.Person
--   union all
-- SELECT [BusinessEntityID]
--       ,[PersonType]
--       ,[NameStyle]
--       ,[FirstName]
--       ,[LastName]
--       ,[EmailPromotion]
--       ,[ModifiedDate]
--   FROM [AdventureWorks2014].[Person].[Person]
--   where FirstName = 'John'

--   create view e as 
--   select [BusinessEntityID]
--       ,[PersonType]
--       ,[NameStyle]
--       ,[FirstName]
--       ,[LastName]
--       ,[EmailPromotion]
--       ,[ModifiedDate]
--   from person.Person
--   union all
--   select [BusinessEntityID]
--       ,[PersonType]
--       ,[NameStyle]
--       ,[FirstName]
--       ,[LastName]
--       ,[EmailPromotion]
--       ,[ModifiedDate]
--   from person.Person
--   where BusinessEntityID in (6,7,8)

   --drop view v
   --drop view e
  
--   select * from v
--   select * from e


-- First part all records that are in v but not in e

select * from

(select [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[FirstName]
      ,[LastName]
      ,[EmailPromotion]
      ,[ModifiedDate]
	  , count(*) as cnt
	  from v 
	  group by
	  [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[FirstName]
      ,[LastName]
      ,[EmailPromotion]
      ,[ModifiedDate]
	  ) v_w
      
	  where not exists (
	 
	  select null from
	  (select 
	   [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[FirstName]
      ,[LastName]
      ,[EmailPromotion]
      ,[ModifiedDate]
	  , count(*) as cnt
	  from e
	  group by
	  [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[FirstName]
      ,[LastName]
      ,[EmailPromotion]
      ,[ModifiedDate]
	  ) e_p

	  where 
	   e_p.[BusinessEntityID] = v_w.[BusinessEntityID]
      and e_p.[PersonType] = v_w.[PersonType]
      and e_p.[NameStyle] = v_w.[NameStyle]
      and e_p.[FirstName] = v_w.[FirstName]
      and e_p.[LastName] = v_w.[LastName]
      and e_p.[EmailPromotion] = v_w.[EmailPromotion]
      and e_p.[ModifiedDate] = v_w.[ModifiedDate]
	  and  e_p.[cnt] = v_w.[cnt]
	  )


union all 

-- second part all records in e that is not in v

select * from

(select 
	   [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[FirstName]
      ,[LastName]
      ,[EmailPromotion]
      ,[ModifiedDate]
	  , count(*) as cnt
	  from e
	  group by
	  [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[FirstName]
      ,[LastName]
      ,[EmailPromotion]
      ,[ModifiedDate]
	  ) e_p

 where not exists (
	 
	  select null from
	(select [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[FirstName]
      ,[LastName]
      ,[EmailPromotion]
      ,[ModifiedDate]
	  , count(*) as cnt
	  from v 
	  group by
	  [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[FirstName]
      ,[LastName]
      ,[EmailPromotion]
      ,[ModifiedDate]
	  ) v_w

	  where 
	   e_p.[BusinessEntityID] = v_w.[BusinessEntityID]
      and e_p.[PersonType] = v_w.[PersonType]
      and e_p.[NameStyle] = v_w.[NameStyle]
      and e_p.[FirstName] = v_w.[FirstName]
      and e_p.[LastName] = v_w.[LastName]
      and e_p.[EmailPromotion] = v_w.[EmailPromotion]
      and e_p.[ModifiedDate] = v_w.[ModifiedDate]
	  and  e_p.[cnt] = v_w.[cnt]
	  )