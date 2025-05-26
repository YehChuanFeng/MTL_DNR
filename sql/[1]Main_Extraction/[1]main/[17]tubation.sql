DROP TABLE IF EXISTS data_9.tubation; 
CREATE TABLE data_9.tubation AS


WITH tb as 
(
	SELECT
		stay_id,
		DATE(starttime) as date,
		CASE when itemid = '224385' then 1 else 0 end as intubation,
		CASE when itemid = '227194' then 1 else 0 end as extubation
	FROM 
		mimiciv_icu.procedureevents
	WHERE 
		itemid in ('224385','227194')
)
, tb2 as 
(
	SELECT
		stay_id,
		date,
		MAX(intubation) AS intubation,
		MAX(extubation) AS extubation
	FROM
		tb
	GROUP BY
		stay_id,date
)

select * from tb2
order by stay_id,date