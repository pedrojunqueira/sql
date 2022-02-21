
with klemzig as (

select ad.date_created
	  , ad.date_last_modified
	  , ad.number_first
	  , ad.number_first_suffix
	  , sl.street_name
	  , sl.street_type_code
	  , ad.postcode
	  , ad.street_locality_pid
	  , ad.locality_pid
	  , ad.alias_principal
	  , ad.legal_parcel_id
	  , ad.confidence
	  , ad.address_site_pid
	  , ad.level_geocoded_code
      , ad.gnaf_property_pid
	  , l.locality_name
	  , geo.latitude
	  , geo.longitude

from raw_gnaf_202202.address_detail ad
	inner join raw_gnaf_202202.locality l on ad.locality_pid = l.locality_pid
		inner join raw_gnaf_202202.state s on s.state_pid = l.state_pid
	inner join raw_gnaf_202202.street_locality sl on sl.street_locality_pid = ad.street_locality_pid
	inner join raw_gnaf_202202.address_site_geocode geo on geo.address_site_pid = ad.address_site_pid
where postcode = '5087'
	--and l.locality_name = 'KLEMZIG'
	and ad.address_detail_pid in 
	(
    'GASA_415297632'
  , 'GASA_415297641'
  , 'GASA_415297640'
  , 'GASA_416761807'
  , 'GASA_424830507'
  , 'GASA_415297642'
  , 'GASA_415297636'
  , 'GASA_415292169'
  , 'GASA_415297638'
  , 'GASA_415297631'
  , 'GASA_415297639'
  , 'GASA_415297630'
  , 'GASA_415297637'
  , 'GASA_415297633'
	)

	)
select *
-- street_name, street_type_code, postcode, locality_name
from klemzig
--where street_name = 'BERRY'
