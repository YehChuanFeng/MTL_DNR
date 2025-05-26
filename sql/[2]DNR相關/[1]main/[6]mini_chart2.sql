DROP table IF EXISTS pj_dnr.DNR_table2;  
create table pj_dnr.DNR_table2 AS

/*
其他DNR相關特徵，可以和mini_chart.sql合併
*/

with DNR_table as 
(
	select 
		stay_id
		, DATE(charttime) AS date
		, MAX(case when itemid in (228409) THEN valuenum else null END) as "Strength L Arm"
		, MAX(case when itemid in (228410) THEN valuenum else null END) as "Strength L Leg"
		, MAX(case when itemid in (228412) THEN valuenum else null END) as "Strength R Arm"
		, MAX(CASE WHEN itemid in (228411) THEN valuenum ELSE NULL END) AS "Strength R Leg"
		, MAX(CASE WHEN itemid in (224756) THEN value ELSE NULL END) AS "Response"
		, MAX(CASE WHEN itemid in (228953) THEN value ELSE NULL END) AS "Coping/Knowledge Deficit  NCP - Expected outcomes"
	FROM
		mimiciv_icu.chartevents
	WHERE 
		itemid in 
		(
			228409,228410,228412,228411,
			224756,
			228953
		) 
	GROUP BY 
		stay_id,date
)

select * from DNR_table