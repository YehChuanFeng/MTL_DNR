DROP table IF EXISTS pj_dnr.target_select;  
create table pj_dnr.target_select AS

WITH cohort1 AS
(
	SELECT 
		stay_id as select_id,
		icu_intime,
		icu_outtime
	FROM 
		data_9.icu_detail
	WHERE
		hospstay_seq = 1 and icustay_seq = 1 and los_icu >= 4 and age >=18
		 --icustay_seq = 1 and los_icu >= 4 and age >=18
)
, cohort2 AS
(
	SELECT 
		stay_id
	FROM 
		pj_dnr.target
	WHERE
		"CCU" = 1 or "MICU" = 1 or "MICU/SICU" = 1 or "Neuro Intermediate" = 1 or "Neuro Stepdown" = 1 or "TSICU" = 1
	GROUP BY
		stay_id
	'Neuro SICU', 'SICU'
)
, cohort AS
(
	SELECT 
		select_id,
		icu_intime,
		icu_outtime
	FROM 
		cohort1
	INNER JOIN
		cohort2
	ON
		cohort1.select_id = cohort2.stay_id
)
, target as 
(
	SELECT 
		* 
	FROM 
		pj_dnr.target,cohort
	WHERE
		pj_dnr.target.stay_id = cohort.select_id and pj_dnr.target.date >= icu_intime and pj_dnr.target.date <= icu_outtime
	ORDER BY stay_id,date
)

select * from target


