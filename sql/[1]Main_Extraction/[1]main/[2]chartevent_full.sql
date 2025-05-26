DROP TABLE IF EXISTS data_9.chart_hour; 
CREATE TABLE data_9.chart_hour AS


WITH chart AS
(
	SELECT
		stay_id
 	  , to_date(charttime::text, 'yyyy-mm-dd') as date
	  , DATE_PART('hour', charttime) AS hour
	  , charttime
	  -----------------  生命體徵 (Vitalaperiodic / Vitalperiodic)==>共6個  ------------------
	  , AVG(case when itemid in (220277) then valuenum else null end) as "SaO2"
	  , AVG(case when itemid in (-1) then valuenum else null end) as "Respiration"  -----找不到
	  , AVG(case when itemid in (220045)  then valuenum else null end) as "Heart Rate"
	  , AVG(case when itemid in (220179,220050)  then valuenum else null end) as "Systemic Systolic"
	  , AVG(case when itemid in (220180,220051)  then valuenum else null end) as "Systemic Diastolic"
	  , AVG(case when itemid in (220052,220181,225312)  then valuenum else null end) as "Systemic Mean"
	  ----------------------------------------------------------------------
	  ------------------呼吸照護 (Respiratorycharting) ----------------------
	  , AVG(case when itemid in (229661) then valuenum else null end) as "Compliance"
	  --, AVG(case when itemid in (223835) then valuenum else null end) as "FiO2"
	  --, AVG(case when itemid in (224700,220339) then valuenum else null end) as "PEEP"
	  , AVG(case when itemid in (220293,220292,224687) then valuenum else null end) as "Minute Ventilation"
	  , AVG(case when itemid in (224697) then valuenum else null end) as "Mean Airway Pressure"
	  , AVG(case when itemid in (224695) then valuenum else null end) as "Peak Airway Pressure" 
	  , AVG(case when itemid in (-1) then valuenum else null end) as "PC mode"    ---------------------找不到
	  , AVG(case when itemid in (-1) then valuenum else null end) as "Pressure Support"    ------------找不到
	  , AVG(case when itemid in (224696) then valuenum else null end) as "Plateau"
	  , AVG(case when itemid in (224685,224686,224684,50826) then valuenum else null end) as "Tidal Volume"
	  , AVG(case when itemid in (220210,224690) then valuenum else null end) as "Respiratory Rate"
	  , AVG(case when itemid in (-1)  then valuenum else null end) as "ROXindex"  -----------找不到  (計算獲得的)
	  , MAX(case when itemid in  ('228905') and value = 'Daily RSBI' then 1 else 0 end) as "Daily RSBI"
	  , MAX(case when itemid in  ('224833') and value = 'Unable to perform RSBI' then 1 else 0 end) as "Unable RSBI"
	  , MAX(case when itemid in  ('228096') then valuenum else null end) as "RASS"

	  ------------------------------------------------------------------------------------------------
	FROM
		mimiciv_icu.chartevents

	WHERE
		itemid in 
		(
			---------------
			 220277
			,-1
			,220045
			,220179,220050
			,220180,220051
			,220052,220181,225312
			---------------
			,229661
			--,223835
			--,224700,220339
			,220293,220292,224687
			,224697
			,224695
			,-1
			,-1
			,224696
			,224685,224686,224684,50826
			,220210,224690
			,-1
			,228905
			,224833
			,228096
			---------------
		) 
	GROUP BY
		--stay_id,date,hour
		stay_id,charttime
)
, vent_hour as 
(
	SELECT
		stay_id,
	    to_date(charttime::text, 'yyyy-mm-dd') as date,
	    DATE_PART('hour', charttime) AS hour,
		charttime,
		MAX("PEEP") as "PEEP",
		MAX("FiO2") as "FiO2"
	FROM 
		data_9.vent
	GROUP BY
		--stay_id,date,hour
		stay_id,charttime
)

SELECT 
	  COALESCE(chart.stay_id,vent_hour.stay_id) as stay_id,
	  COALESCE(chart.date,vent_hour.date) as date,
	  COALESCE(chart.hour,vent_hour.hour) as hour,
	  COALESCE(chart.charttime,vent_hour.charttime) as charttime,
	  "SaO2",
	  "Respiration",  -----找不到
	  "Heart Rate",
	  "Systemic Systolic",
	  "Systemic Diastolic",
	  "Systemic Mean",
	  ------------------ 呼吸照護 (Respiratorycharting) ----------------------
	  "Compliance",
	  "FiO2",
	  "PEEP",
	  "Minute Ventilation",
	  "Mean Airway Pressure",
	  "Peak Airway Pressure",
	  "PC mode",    ---------------------找不到
	  "Pressure Support",    ------------找不到
	  "Plateau",
	  "Tidal Volume",
	  "Respiratory Rate",
	  "ROXindex",  -----------找不到  (計算獲得的)
	  "Daily RSBI",
	  "Unable RSBI",
	  "RASS"
FROM 
	chart
FULL JOIN
	vent_hour
ON
	--chart.stay_id = vent_hour.stay_id and chart.date = vent_hour.date and chart.hour = vent_hour.hour
	chart.stay_id = vent_hour.stay_id and chart.charttime = vent_hour.charttime
ORDER BY
	stay_id,date,hour

