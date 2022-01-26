USE [AdventureWorks2014]

go

SELECT p.BusinessEntityID, FirstName, LastName, e.EmailAddress
  FROM [Person].[Person] p, [Person].[EmailAddress] e
  where p.BusinessEntityID = e.BusinessEntityID