DROP table IF EXISTS data_9.HFNC; 
create table data_9.HFNC AS

with a as 
(
	SELECT 
		stay_id as vent_stay_id
		, to_date(starttime::text, 'yyyy-mm-dd') as start_date
		, to_date(endtime::text, 'yyyy-mm-dd') as end_date
	    , ventilation_status as ventilation_status2
	FROM
		data_9.ventilation
	Where
		ventilation_status = 'HFNC'

)


, b as 
(
	SELECT 
		*,
		end_date - start_date AS vent_day
	FROM 
		a
	WHERE
		(end_date - start_date) >= 0    -- 等於沒加 
	ORDER BY 
		vent_stay_id,end_date
)

SELECT
	*
FROM
	b