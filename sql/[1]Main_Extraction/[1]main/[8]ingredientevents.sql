--20230130 以小時為單位group by   接著Group by到天=>若使用>=4小時 當天視為有使用

DROP table IF EXISTS data_9.ingredientevents_select; 
create table data_9.ingredientevents_select AS


--stay_id為索引
with target as 
(
	SELECT  
		*,
    	case
            when itemid in (221906,221289,221662,222315) then 'Vasopressor'
            when itemid in (222062) then 'Relaxant'
            when itemid in (221668,222168,225150) then 'Sedation'
            when itemid in (225910) then 'PPI'
            when itemid in (221744) then 'Pain control'
        end as label 
	FROM 
		mimiciv_icu.inputevents

)

--Group by到時為單位，有使用即為1
, a as 
(
	SELECT
		stay_id,
		DATE_PART('year',starttime) as year,
		DATE_PART('month',starttime) as month,
		DATE_PART('DAY',starttime) as date,
		DATE_PART('HOUR',starttime) as hour,
		MAX(case when label =  'Vasopressor' then 1 else 0 end) as "Vasopressor",
		MAX(case when label =  'Relaxant' then 1 else 0 end) as "Relaxant",
		MAX(case when label =  'Sedation' then 1 else 0 end) as "Sedation",
		MAX(case when label =  'PPI' then 1 else 0 end) as "PPI",
		MAX(case when label =  'Pain control' then 1 else 0 end) as "Pain control"
	FROM 
		target
	WHERE 
		label is not null
	GROUP BY 
		stay_id,year,month,date,hour
	ORDER BY 
		stay_id,year,month,date,hour
)

--Group by到天為單位 滿4小時當天即為1
, b as 
(
	SELECT
		stay_id,
		year,
		month,
		date,
		(case when SUM("Vasopressor") >= 4 then 1 else 0 end) as "Vasopressor",
		(case when SUM("Relaxant") >= 4 then 1 else 0 end) as "Relaxant",
		(case when SUM("Sedation") >= 4 then 1 else 0 end) as "Sedation",
		(case when SUM("PPI") >= 4 then 1 else 0 end) as "PPI",
		(case when SUM("Pain control") >= 4 then 1 else 0 end) as "Pain control"
	FROM 
		a
	GROUP BY 
		stay_id,year,month,date
)

select * from b
