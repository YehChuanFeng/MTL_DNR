DROP table IF EXISTS data_9.SBT; 
create table data_9.SBT AS

with a as 
(
	SELECT
		stay_id,
		charttime,
		--TO_CHAR(charttime, 'YYYY-MM-DD HH24:00:00') AS date_hour,
		to_date(charttime::text, 'yyyy-mm-dd') as date,
		--storetime,
		--chart.itemid,
		case when chart.itemid = '223835' then value else null end as "FiO2",
		case when chart.itemid = '220339' then value else null end as "PEEP",
		--case when chart.itemid = '224715' then value else null end as "SBT Started",
	
		--"SBT_Started"
		case when chart.itemid = '224715' 
			THEN
				CASE
					when value = 'Yes' then 1 
					when value = 'No' then 0
					else 0
				END
		END AS "SBT Started",
	
		case when chart.itemid = '224716' then value else null end as "SBT Stopped",
		--"SBT Successfully Completed"
		case when chart.itemid = '224717' 
			THEN
				CASE
					when value = 'Yes' then 1 --20231028 改成只要有值都是1 而非0、1、2
					when value = 'No' then 1
					else 0
				END
		END AS "SBT Successfully Completed",
		case when chart.itemid = '224833' then value else null end as "SBT Deferred",
		--label,
		--value,
		warning
	FROM
		mimiciv_icu.chartevents as chart,mimiciv_icu.d_items
	WHERE
		chart.itemid in ('223835','220339','224715','224716','224717','224833') and chart.itemid = mimiciv_icu.d_items.itemid
	ORDER BY 
		stay_id,charttime
)

--SBT Successfully Completed 轉數值了   0:NULL 1:No  2:Yes
, b as 
(
	SELECT 
		stay_id,
		date,
		ROUND(AVG("FiO2"::numeric), 1) as "FiO2",
		ROUND(AVG("PEEP"::numeric), 1) as "PEEP",
		--MAX("SBT Started") as "SBT Started",
		COALESCE(CAST(MAX("SBT Started") AS int), 0) as "SBT Started",
		MAX("SBT Stopped") as "SBT Stopped",
		COALESCE(CAST(MAX("SBT Successfully Completed") AS int), 0) as "SBT Successfully Completed",
		MAX("SBT Deferred") as "SBT Deferred"
	FROM
		a
	GROUP BY
		stay_id, date
	ORDER BY
		stay_id, date
)


select * from b
