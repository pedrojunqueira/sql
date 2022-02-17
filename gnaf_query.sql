SELECT distinct
         address_detail_pid
		, number_first
	    , sl.street_name
	    , sl.street_type_code
        , ad.date_created
	    , building_name
	    , lot_number
    	, flat_type_code
	    , flat_number
	    , level_number
	    , number_last
        , ad.street_locality_pid
	    , ad.locality_pid
	    , l.locality_name
	    , s.state_name
	    , s.state_abbreviation
	    , postcode
	    , legal_parcel_id
	    , confidence
	    , ad_s.address_site_pid
	    , ad_s.address_site_name 
	    , ad_site.address_type
	    , ad_site.address_site_name
	    , level_geocoded_code
	
	FROM raw_gnaf_202202.address_detail ad
	inner join raw_gnaf_202202.address_site ad_s on ad.address_site_pid = ad.address_site_pid
	inner join raw_gnaf_202202.address_site ad_site on ad_site.address_site_pid = ad.address_site_pid
	inner join raw_gnaf_202202.street_locality sl on sl.street_locality_pid = ad.street_locality_pid
	inner join raw_gnaf_202202.locality l on ad.locality_pid = l.locality_pid
		inner join raw_gnaf_202202.state s on s.state_pid = l.state_pid
	where s.state_abbreviation = 'SA'
	and ad.postcode = '5087'
	and sl.street_type_code = 'COURT'
	--and sl.street_name like '%berry%'
	--limit 10