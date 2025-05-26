DROP table IF EXISTS pj_dnr.CPOT;  
create table pj_dnr.CPOT AS
/*
CPOT
*/
WITH CPOT AS 
(
	SELECT
		stay_id,
		charttime,
		case when itemid in (229691,229692) then valuenum else null end as "Muscle",
		case when itemid in (229693,229694,229695) then valuenum else null end as "Vocalization",
		case when itemid in (229696, 229697) then valuenum else null end as "Body Movements",
		case when itemid in (229698,229699) then valuenum else null end as "Facial Expressions"
	FROM 
		mimiciv_icu.chartevents
	WHERE 
		itemid in (229691, 229692, 229693, 229694, 229695, 229696, 229697, 229698, 229699)
)
, CPOT_SUM AS
(
	SELECT
		stay_id,
		date(charttime) as date,
		COALESCE(MAX("Muscle"), 0)  as "Muscle",
		COALESCE(MAX("Vocalization"), 0)  as "Vocalization",
		COALESCE(MAX("Body Movements"), 0)  as "Body Movements",
		COALESCE(MAX("Facial Expressions"), 0)  as "Facial Expressions",
		COALESCE(MAX("Muscle"), 0)  + COALESCE(MAX("Vocalization"), 0)  + COALESCE(MAX("Body Movements"), 0)  + COALESCE(MAX("Facial Expressions"), 0)  as "CPOT(SUM)",
		ROW_NUMBER() OVER (PARTITION BY stay_id, DATE(charttime) ORDER BY charttime DESC) AS rn
	FROM 
		CPOT
	GROUP BY
		stay_id,
		charttime
)


select * from CPOT_SUM
where rn = 1 --保留每日最後一比紀錄
order by stay_id,date

