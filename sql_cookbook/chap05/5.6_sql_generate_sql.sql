select FORMATMESSAGE('count(1) from %s', table_name)
from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA = 'dbo'