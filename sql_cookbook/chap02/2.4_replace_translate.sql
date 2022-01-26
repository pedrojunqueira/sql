use [AdventureWorksDW2019] 
go


select data,
replace(data,
replace(
translate(data,'0123456789','##########'),'#',''),'') nums,
replace(
translate(data,'0123456789','##########'),'#','') chars,

translate(data,'0123456789','##########') rplc

from

(
select VacationHours, FirstName,

concat(VacationHours, ' ', FirstName) as data

from [dbo].[DimEmployee]) v

order by replace(data,
replace(
translate(data,'0123456789','##########'),'#',''),'') desc

