DROP table IF EXISTS data_9.PCmode; 
create table data_9.PCmode AS

with all_mode as 
(
	SELECT 
		stay_id,
		to_date(ct.charttime::text, 'yyyy-mm-dd') as date,
		--DATE_PART('hour', charttime) AS hour,
		charttime,
		ROW_NUMBER() OVER (PARTITION BY stay_id,to_date(ct.charttime::text, 'yyyy-mm-dd') ORDER BY charttime DESC) AS rn,
		value
	FROM
		mimiciv_icu.chartevents as ct
	WHERE
		itemid = '223849'
	ORDER BY
		stay_id,charttime
)

, last_mode as 
(
	SELECT 
		stay_id,
		date,
		all_mode.value,
		rn,
		defind_pcmode.class as class
	FROM 
		all_mode
	
	LEFT JOIN 
		defind_pcmode
	ON all_mode.value = defind_pcmode.value
)

, final_output as 
(
	SELECT
		stay_id,
		date,
		(case when class = 'PSV' then 'PSV' else 'AC' end) as "PC_mode"
	FROM
		last_mode
	WHERE 
		rn = 1
)


SELECT
	*
FROM 
	final_output
Order by 
	stay_id,date



