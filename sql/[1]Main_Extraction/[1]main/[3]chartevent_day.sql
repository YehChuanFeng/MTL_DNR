DROP TABLE IF EXISTS data_9.chart; 
CREATE TABLE data_9.chart AS

WITH 
"SaO2" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"SaO2",
		FIRST_VALUE("SaO2") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first SaO2",
		FIRST_VALUE("SaO2") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last SaO2"
	FROM 
		data_9.chart_hour
	WHERE 
		"SaO2" is not null
	ORDER BY
		stay_id,date,hour
)
, "SaO2_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("SaO2") as "max SaO2",
		MIN("SaO2") as "min SaO2",
		MAX("first SaO2") as "first SaO2",
		MAX("last SaO2") as "last SaO2",
		--AVG("SaO2") as "avg SaO2"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "SaO2") AS "avg SaO2"  
	FROM
		"SaO2"
	GROUP BY
		stay_id,date
)
,"Respiration" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Respiration",
		FIRST_VALUE("Respiration") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Respiration",
		FIRST_VALUE("Respiration") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Respiration"
	FROM 
		data_9.chart_hour
	WHERE 
		"Respiration" is not null
	ORDER BY
		stay_id,date,hour
)
, "Respiration_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Respiration") as "max Respiration",
		MIN("Respiration") as "min Respiration",
		MAX("first Respiration") as "first Respiration",
		MAX("last Respiration") as "last Respiration",
		--AVG("Respiration") as "avg Respiration"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Respiration") AS "avg Respiration" 
	FROM
		"Respiration"
	GROUP BY
		stay_id,date
)
,"Heart Rate" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Heart Rate",
		FIRST_VALUE("Heart Rate") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Heart Rate",
		FIRST_VALUE("Heart Rate") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Heart Rate"
	FROM 
		data_9.chart_hour
	WHERE 
		"Heart Rate" is not null
	ORDER BY
		stay_id,date,hour
)
, "Heart Rate_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Heart Rate") as "max Heart Rate",
		MIN("Heart Rate") as "min Heart Rate",
		MAX("first Heart Rate") as "first Heart Rate",
		MAX("last Heart Rate") as "last Heart Rate",
		--AVG("Heart Rate") as "avg Heart Rate"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Heart Rate") AS "avg Heart Rate"  
	FROM
		"Heart Rate"
	GROUP BY
		stay_id,date
)
,"Systemic Systolic" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Systemic Systolic",
		FIRST_VALUE("Systemic Systolic") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Systemic Systolic",
		FIRST_VALUE("Systemic Systolic") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Systemic Systolic"
	FROM 
		data_9.chart_hour
	WHERE 
		"Systemic Systolic" is not null
	ORDER BY
		stay_id,date,hour
)
, "Systemic Systolic_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Systemic Systolic") as "max Systemic Systolic",
		MIN("Systemic Systolic") as "min Systemic Systolic",
		MAX("first Systemic Systolic") as "first Systemic Systolic",
		MAX("last Systemic Systolic") as "last Systemic Systolic",
		--AVG("Systemic Systolic") as "avg Systemic Systolic"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Systemic Systolic") AS "avg Systemic Systolic"  
	FROM
		"Systemic Systolic"
	GROUP BY
		stay_id,date
)
,"Systemic Diastolic" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Systemic Diastolic",
		FIRST_VALUE("Systemic Diastolic") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Systemic Diastolic",
		FIRST_VALUE("Systemic Diastolic") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Systemic Diastolic"
	FROM 
		data_9.chart_hour
	WHERE 
		"Systemic Diastolic" is not null
	ORDER BY
		stay_id,date,hour
)
, "Systemic Diastolic_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Systemic Diastolic") as "max Systemic Diastolic",
		MIN("Systemic Diastolic") as "min Systemic Diastolic",
		MAX("first Systemic Diastolic") as "first Systemic Diastolic",
		MAX("last Systemic Diastolic") as "last Systemic Diastolic",
		--AVG("Systemic Diastolic") as "avg Systemic Diastolic"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Systemic Diastolic") AS "avg Systemic Diastolic"  
	FROM
		"Systemic Diastolic"
	GROUP BY
		stay_id,date
)
,"Systemic Mean" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Systemic Mean",
		FIRST_VALUE("Systemic Mean") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Systemic Mean",
		FIRST_VALUE("Systemic Mean") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Systemic Mean"
	FROM 
		data_9.chart_hour
	WHERE 
		"Systemic Mean" is not null
	ORDER BY
		stay_id,date,hour
)
, "Systemic Mean_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Systemic Mean") as "max Systemic Mean",
		MIN("Systemic Mean") as "min Systemic Mean",
		MAX("first Systemic Mean") as "first Systemic Mean",
		MAX("last Systemic Mean") as "last Systemic Mean",
		--AVG("Systemic Mean") as "avg Systemic Mean"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Systemic Mean") AS "avg Systemic Mean"  
	FROM
		"Systemic Mean"
	GROUP BY
		stay_id,date
)
,"Compliance" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Compliance",
		FIRST_VALUE("Compliance") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Compliance",
		FIRST_VALUE("Compliance") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Compliance"
	FROM 
		data_9.chart_hour
	WHERE 
		"Compliance" is not null
	ORDER BY
		stay_id,date,hour
)
, "Compliance_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Compliance") as "max Compliance",
		MIN("Compliance") as "min Compliance",
		MAX("first Compliance") as "first Compliance",
		MAX("last Compliance") as "last Compliance",
		--AVG("Compliance") as "avg Compliance"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Compliance") AS "avg Compliance"  
	FROM
		"Compliance"
	GROUP BY
		stay_id,date
)
,"FiO2" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"FiO2",
		FIRST_VALUE("FiO2") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first FiO2",
		FIRST_VALUE("FiO2") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last FiO2"
	FROM 
		data_9.chart_hour
	WHERE 
		"FiO2" is not null
	ORDER BY
		stay_id,date,hour
)
, "FiO2_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("FiO2") as "max FiO2",
		MIN("FiO2") as "min FiO2",
		MAX("first FiO2") as "first FiO2",
		MAX("last FiO2") as "last FiO2",
		--AVG("FiO2") as "avg FiO2"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "FiO2") AS "avg FiO2" 
	FROM
		"FiO2"
	GROUP BY
		stay_id,date
)
,"Minute Ventilation" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Minute Ventilation",
		FIRST_VALUE("Minute Ventilation") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Minute Ventilation",
		FIRST_VALUE("Minute Ventilation") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Minute Ventilation"
	FROM 
		data_9.chart_hour
	WHERE 
		"Minute Ventilation" is not null
	ORDER BY
		stay_id,date,hour
)
, "Minute Ventilation_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Minute Ventilation") as "max Minute Ventilation",
		MIN("Minute Ventilation") as "min Minute Ventilation",
		MAX("first Minute Ventilation") as "first Minute Ventilation",
		MAX("last Minute Ventilation") as "last Minute Ventilation",
		--AVG("Minute Ventilation") as "avg Minute Ventilation"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Minute Ventilation") AS "avg Minute Ventilation"  
	FROM
		"Minute Ventilation"
	GROUP BY
		stay_id,date
)
,"Mean Airway Pressure" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Mean Airway Pressure",
		FIRST_VALUE("Mean Airway Pressure") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Mean Airway Pressure",
		FIRST_VALUE("Mean Airway Pressure") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Mean Airway Pressure"
	FROM 
		data_9.chart_hour
	WHERE 
		"Mean Airway Pressure" is not null
	ORDER BY
		stay_id,date,hour
)
, "Mean Airway Pressure_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Mean Airway Pressure") as "max Mean Airway Pressure",
		MIN("Mean Airway Pressure") as "min Mean Airway Pressure",
		MAX("first Mean Airway Pressure") as "first Mean Airway Pressure",
		MAX("last Mean Airway Pressure") as "last Mean Airway Pressure",
		--AVG("Mean Airway Pressure") as "avg Mean Airway Pressure"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Mean Airway Pressure") AS "avg Mean Airway Pressure"  
	FROM
		"Mean Airway Pressure"
	GROUP BY
		stay_id,date
)
,"Peak Airway Pressure" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Peak Airway Pressure",
		FIRST_VALUE("Peak Airway Pressure") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Peak Airway Pressure",
		FIRST_VALUE("Peak Airway Pressure") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Peak Airway Pressure"
	FROM 
		data_9.chart_hour
	WHERE 
		"Peak Airway Pressure" is not null
	ORDER BY
		stay_id,date,hour
)
, "Peak Airway Pressure_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Peak Airway Pressure") as "max Peak Airway Pressure",
		MIN("Peak Airway Pressure") as "min Peak Airway Pressure",
		MAX("first Peak Airway Pressure") as "first Peak Airway Pressure",
		MAX("last Peak Airway Pressure") as "last Peak Airway Pressure",
		--AVG("Peak Airway Pressure") as "avg Peak Airway Pressure"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Peak Airway Pressure") AS "avg Peak Airway Pressure"  
	FROM
		"Peak Airway Pressure"
	GROUP BY
		stay_id,date
)
,"PEEP" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"PEEP",
		FIRST_VALUE("PEEP") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first PEEP",
		FIRST_VALUE("PEEP") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last PEEP"
	FROM 
		data_9.chart_hour
	WHERE 
		"PEEP" is not null
	ORDER BY
		stay_id,date,hour
)
, "PEEP_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("PEEP") as "max PEEP",
		MIN("PEEP") as "min PEEP",
		MAX("first PEEP") as "first PEEP",
		MAX("last PEEP") as "last PEEP",
		--AVG("PEEP") as "avg PEEP"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "PEEP") AS "avg PEEP"  
	FROM
		"PEEP"
	GROUP BY
		stay_id,date
)
,"PC mode" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"PC mode",
		FIRST_VALUE("PC mode") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first PC mode",
		FIRST_VALUE("PC mode") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last PC mode"
	FROM 
		data_9.chart_hour
	WHERE 
		"PC mode" is not null
	ORDER BY
		stay_id,date,hour
)
, "PC mode_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("PC mode") as "max PC mode",
		MIN("PC mode") as "min PC mode",
		MAX("first PC mode") as "first PC mode",
		MAX("last PC mode") as "last PC mode",
		--AVG("PC mode") as "avg PC mode"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "PC mode") AS "avg PC mode"  
	FROM
		"PC mode"
	GROUP BY
		stay_id,date
)
,"Pressure Support" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Pressure Support",
		FIRST_VALUE("Pressure Support") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Pressure Support",
		FIRST_VALUE("Pressure Support") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Pressure Support"
	FROM 
		data_9.chart_hour
	WHERE 
		"Pressure Support" is not null
	ORDER BY
		stay_id,date,hour
)
, "Pressure Support_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Pressure Support") as "max Pressure Support",
		MIN("Pressure Support") as "min Pressure Support",
		MAX("first Pressure Support") as "first Pressure Support",
		MAX("last Pressure Support") as "last Pressure Support",
		--AVG("Pressure Support") as "avg Pressure Support"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Pressure Support") AS "avg Pressure Support"  
	FROM
		"Pressure Support"
	GROUP BY
		stay_id,date
)
,"Plateau" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Plateau",
		FIRST_VALUE("Plateau") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Plateau",
		FIRST_VALUE("Plateau") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Plateau"
	FROM 
		data_9.chart_hour
	WHERE 
		"Plateau" is not null
	ORDER BY
		stay_id,date,hour
)
, "Plateau_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Plateau") as "max Plateau",
		MIN("Plateau") as "min Plateau",
		MAX("first Plateau") as "first Plateau",
		MAX("last Plateau") as "last Plateau",
		--AVG("Plateau") as "avg Plateau"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Plateau") AS "avg Plateau" 
	FROM
		"Plateau"
	GROUP BY
		stay_id,date
)
,"Tidal Volume" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Tidal Volume",
		FIRST_VALUE("Tidal Volume") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Tidal Volume",
		FIRST_VALUE("Tidal Volume") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Tidal Volume"
	FROM 
		data_9.chart_hour
	WHERE 
		"Tidal Volume" is not null
	ORDER BY
		stay_id,date,hour
)
, "Tidal Volume_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Tidal Volume") as "max Tidal Volume",
		MIN("Tidal Volume") as "min Tidal Volume",
		MAX("first Tidal Volume") as "first Tidal Volume",
		MAX("last Tidal Volume") as "last Tidal Volume",
		--AVG("Tidal Volume") as "avg Tidal Volume"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Tidal Volume") AS "avg Tidal Volume"  
	FROM
		"Tidal Volume"
	GROUP BY
		stay_id,date
)
,"Respiratory Rate" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Respiratory Rate",
		FIRST_VALUE("Respiratory Rate") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Respiratory Rate",
		FIRST_VALUE("Respiratory Rate") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Respiratory Rate"
	FROM 
		data_9.chart_hour
	WHERE 
		"Respiratory Rate" is not null
	ORDER BY
		stay_id,date,hour
)
, "Respiratory Rate_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Respiratory Rate") as "max Respiratory Rate",
		MIN("Respiratory Rate") as "min Respiratory Rate",
		MAX("first Respiratory Rate") as "first Respiratory Rate",
		MAX("last Respiratory Rate") as "last Respiratory Rate",
		--AVG("Respiratory Rate") as "avg Respiratory Rate"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Respiratory Rate") AS "avg Respiratory Rate"  
	FROM
		"Respiratory Rate"
	GROUP BY
		stay_id,date
)
,"ROXindex" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"ROXindex",
		FIRST_VALUE("ROXindex") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first ROXindex",
		FIRST_VALUE("ROXindex") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last ROXindex"
	FROM 
		data_9.chart_hour
	WHERE 
		"ROXindex" is not null
	ORDER BY
		stay_id,date,hour
)
, "ROXindex_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("ROXindex") as "max ROXindex",
		MIN("ROXindex") as "min ROXindex",
		MAX("first ROXindex") as "first ROXindex",
		MAX("last ROXindex") as "last ROXindex",
		--AVG("ROXindex") as "avg ROXindex"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "ROXindex") AS "avg ROXindex"  
	FROM
		"ROXindex"
	GROUP BY
		stay_id,date
)
,"Daily RSBI" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Daily RSBI",
		FIRST_VALUE("Daily RSBI") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Daily RSBI",
		FIRST_VALUE("Daily RSBI") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Daily RSBI"
	FROM 
		data_9.chart_hour
	WHERE 
		"Daily RSBI" is not null
	ORDER BY
		stay_id,date,hour
)
, "Daily RSBI_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Daily RSBI") as "max Daily RSBI",
		MIN("Daily RSBI") as "min Daily RSBI",
		MAX("first Daily RSBI") as "first Daily RSBI",
		MAX("last Daily RSBI") as "last Daily RSBI",
		--AVG("Daily RSBI") as "avg Daily RSBI"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Daily RSBI") AS "avg Daily RSBI" 
	FROM
		"Daily RSBI"
	GROUP BY
		stay_id,date
)
,"Unable RSBI" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"Unable RSBI",
		FIRST_VALUE("Unable RSBI") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first Unable RSBI",
		FIRST_VALUE("Unable RSBI") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last Unable RSBI"
	FROM 
		data_9.chart_hour
	WHERE 
		"Unable RSBI" is not null
	ORDER BY
		stay_id,date,hour
)
, "Unable RSBI_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("Unable RSBI") as "max Unable RSBI",
		MIN("Unable RSBI") as "min Unable RSBI",
		MAX("first Unable RSBI") as "first Unable RSBI",
		MAX("last Unable RSBI") as "last Unable RSBI",
		--AVG("Unable RSBI") as "avg Unable RSBI"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "Unable RSBI") AS "avg Unable RSBI"  
	FROM
		"Unable RSBI"
	GROUP BY
		stay_id,date
)
,"RASS" AS
(
	SELECT 
		stay_id,
		date,
		hour,
		"RASS",
		FIRST_VALUE("RASS") OVER (PARTITION BY stay_id, date ORDER BY date,hour ) AS "first RASS",
		FIRST_VALUE("RASS") OVER (PARTITION BY stay_id, date ORDER BY date,hour DESC) AS "last RASS"
	FROM 
		data_9.chart_hour
	WHERE 
		"RASS" is not null
	ORDER BY
		stay_id,date,hour
)
, "RASS_statistics" as 
(
	SELECT
		stay_id,
		date,		
		MAX("RASS") as "max RASS",
		MIN("RASS") as "min RASS",
		MAX("first RASS") as "first RASS",
		MAX("last RASS") as "last RASS",
		--AVG("RASS") as "avg RASS"
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY "RASS") AS "avg RASS"  
	FROM
		"RASS"
	GROUP BY
		stay_id,date
)

--select * from "FiO2_statistics"
, final as 
(
	SELECT 
		"SaO2_statistics".stay_id as stay_id_0,
		"SaO2_statistics".date as date_0,
		"Respiration_statistics".stay_id as stay_id_1,
		"Respiration_statistics".date as date_1,
		"Heart Rate_statistics".stay_id as stay_id_2,
		"Heart Rate_statistics".date as date_2,
		"Systemic Systolic_statistics".stay_id as stay_id_3,
		"Systemic Systolic_statistics".date as date_3,
		"Systemic Diastolic_statistics".stay_id as stay_id_4,
		"Systemic Diastolic_statistics".date as date_4,
		"Systemic Mean_statistics".stay_id as stay_id_5,
		"Systemic Mean_statistics".date as date_5,
		"Compliance_statistics".stay_id as stay_id_6,
		"Compliance_statistics".date as date_6,
		"FiO2_statistics".stay_id as stay_id_7,
		"FiO2_statistics".date as date_7,
		"Minute Ventilation_statistics".stay_id as stay_id_8,
		"Minute Ventilation_statistics".date as date_8,
		"Mean Airway Pressure_statistics".stay_id as stay_id_9,
		"Mean Airway Pressure_statistics".date as date_9,
		"Peak Airway Pressure_statistics".stay_id as stay_id_10,
		"Peak Airway Pressure_statistics".date as date_10,
		"PEEP_statistics".stay_id as stay_id_11,
		"PEEP_statistics".date as date_11,
		"PC mode_statistics".stay_id as stay_id_12,
		"PC mode_statistics".date as date_12,
		"Pressure Support_statistics".stay_id as stay_id_13,
		"Pressure Support_statistics".date as date_13,
		"Plateau_statistics".stay_id as stay_id_14,
		"Plateau_statistics".date as date_14,
		"Tidal Volume_statistics".stay_id as stay_id_15,
		"Tidal Volume_statistics".date as date_15,
		"Respiratory Rate_statistics".stay_id as stay_id_16,
		"Respiratory Rate_statistics".date as date_16,
		"ROXindex_statistics".stay_id as stay_id_17,
		"ROXindex_statistics".date as date_17,
		"Daily RSBI_statistics".stay_id as stay_id_18,
		"Daily RSBI_statistics".date as date_18,
		"Unable RSBI_statistics".stay_id as stay_id_19,
		"Unable RSBI_statistics".date as date_19,
		"RASS_statistics".stay_id as stay_id_20,
		"RASS_statistics".date as date_20,
	
		"SaO2_statistics"."max SaO2",
		"SaO2_statistics"."min SaO2",
		"SaO2_statistics"."first SaO2",
		"SaO2_statistics"."last SaO2",
		"SaO2_statistics"."avg SaO2",
		"Respiration_statistics"."max Respiration",
		"Respiration_statistics"."min Respiration",
		"Respiration_statistics"."first Respiration",
		"Respiration_statistics"."last Respiration",
		"Respiration_statistics"."avg Respiration",
		"Heart Rate_statistics"."max Heart Rate",
		"Heart Rate_statistics"."min Heart Rate",
		"Heart Rate_statistics"."first Heart Rate",
		"Heart Rate_statistics"."last Heart Rate",
		"Heart Rate_statistics"."avg Heart Rate",
		"Systemic Systolic_statistics"."max Systemic Systolic",
		"Systemic Systolic_statistics"."min Systemic Systolic",
		"Systemic Systolic_statistics"."first Systemic Systolic",
		"Systemic Systolic_statistics"."last Systemic Systolic",
		"Systemic Systolic_statistics"."avg Systemic Systolic",
		"Systemic Diastolic_statistics"."max Systemic Diastolic",
		"Systemic Diastolic_statistics"."min Systemic Diastolic",
		"Systemic Diastolic_statistics"."first Systemic Diastolic",
		"Systemic Diastolic_statistics"."last Systemic Diastolic",
		"Systemic Diastolic_statistics"."avg Systemic Diastolic",
		"Systemic Mean_statistics"."max Systemic Mean",
		"Systemic Mean_statistics"."min Systemic Mean",
		"Systemic Mean_statistics"."first Systemic Mean",
		"Systemic Mean_statistics"."last Systemic Mean",
		"Systemic Mean_statistics"."avg Systemic Mean",
		"Compliance_statistics"."max Compliance",
		"Compliance_statistics"."min Compliance",
		"Compliance_statistics"."first Compliance",
		"Compliance_statistics"."last Compliance",
		"Compliance_statistics"."avg Compliance",
		"FiO2_statistics"."max FiO2",
		"FiO2_statistics"."min FiO2",
		"FiO2_statistics"."first FiO2",
		"FiO2_statistics"."last FiO2",
		"FiO2_statistics"."avg FiO2",
		"Minute Ventilation_statistics"."max Minute Ventilation",
		"Minute Ventilation_statistics"."min Minute Ventilation",
		"Minute Ventilation_statistics"."first Minute Ventilation",
		"Minute Ventilation_statistics"."last Minute Ventilation",
		"Minute Ventilation_statistics"."avg Minute Ventilation",
		"Mean Airway Pressure_statistics"."max Mean Airway Pressure",
		"Mean Airway Pressure_statistics"."min Mean Airway Pressure",
		"Mean Airway Pressure_statistics"."first Mean Airway Pressure",
		"Mean Airway Pressure_statistics"."last Mean Airway Pressure",
		"Mean Airway Pressure_statistics"."avg Mean Airway Pressure",
		"Peak Airway Pressure_statistics"."max Peak Airway Pressure",
		"Peak Airway Pressure_statistics"."min Peak Airway Pressure",
		"Peak Airway Pressure_statistics"."first Peak Airway Pressure",
		"Peak Airway Pressure_statistics"."last Peak Airway Pressure",
		"Peak Airway Pressure_statistics"."avg Peak Airway Pressure",
		"PEEP_statistics"."max PEEP",
		"PEEP_statistics"."min PEEP",
		"PEEP_statistics"."first PEEP",
		"PEEP_statistics"."last PEEP",
		"PEEP_statistics"."avg PEEP",
		"PC mode_statistics"."max PC mode",
		"PC mode_statistics"."min PC mode",
		"PC mode_statistics"."first PC mode",
		"PC mode_statistics"."last PC mode",
		"PC mode_statistics"."avg PC mode",
		"Pressure Support_statistics"."max Pressure Support",
		"Pressure Support_statistics"."min Pressure Support",
		"Pressure Support_statistics"."first Pressure Support",
		"Pressure Support_statistics"."last Pressure Support",
		"Pressure Support_statistics"."avg Pressure Support",
		"Plateau_statistics"."max Plateau",
		"Plateau_statistics"."min Plateau",
		"Plateau_statistics"."first Plateau",
		"Plateau_statistics"."last Plateau",
		"Plateau_statistics"."avg Plateau",
		"Tidal Volume_statistics"."max Tidal Volume",
		"Tidal Volume_statistics"."min Tidal Volume",
		"Tidal Volume_statistics"."first Tidal Volume",
		"Tidal Volume_statistics"."last Tidal Volume",
		"Tidal Volume_statistics"."avg Tidal Volume",
		"Respiratory Rate_statistics"."max Respiratory Rate",
		"Respiratory Rate_statistics"."min Respiratory Rate",
		"Respiratory Rate_statistics"."first Respiratory Rate",
		"Respiratory Rate_statistics"."last Respiratory Rate",
		"Respiratory Rate_statistics"."avg Respiratory Rate",
		"ROXindex_statistics"."max ROXindex",
		"ROXindex_statistics"."min ROXindex",
		"ROXindex_statistics"."first ROXindex",
		"ROXindex_statistics"."last ROXindex",
		"ROXindex_statistics"."avg ROXindex",
		"Daily RSBI_statistics"."max Daily RSBI",
		"Daily RSBI_statistics"."min Daily RSBI",
		"Daily RSBI_statistics"."first Daily RSBI",
		"Daily RSBI_statistics"."last Daily RSBI",
		"Daily RSBI_statistics"."avg Daily RSBI",
		"Unable RSBI_statistics"."max Unable RSBI",
		"Unable RSBI_statistics"."min Unable RSBI",
		"Unable RSBI_statistics"."first Unable RSBI",
		"Unable RSBI_statistics"."last Unable RSBI",
		"Unable RSBI_statistics"."avg Unable RSBI",
		"RASS_statistics"."max RASS",
		"RASS_statistics"."min RASS",
		"RASS_statistics"."first RASS",
		"RASS_statistics"."last RASS",
		"RASS_statistics"."avg RASS"
	FROM "SaO2_statistics"
	FULL JOIN "Respiration_statistics" ON "SaO2_statistics".stay_id = "Respiration_statistics".stay_id and "SaO2_statistics".date = "Respiration_statistics".date
	FULL JOIN "Heart Rate_statistics" ON "SaO2_statistics".stay_id = "Heart Rate_statistics".stay_id and "SaO2_statistics".date = "Heart Rate_statistics".date
	FULL JOIN "Systemic Systolic_statistics" ON "SaO2_statistics".stay_id = "Systemic Systolic_statistics".stay_id and "SaO2_statistics".date = "Systemic Systolic_statistics".date
	FULL JOIN "Systemic Diastolic_statistics" ON "SaO2_statistics".stay_id = "Systemic Diastolic_statistics".stay_id and "SaO2_statistics".date = "Systemic Diastolic_statistics".date
	FULL JOIN "Systemic Mean_statistics" ON "SaO2_statistics".stay_id = "Systemic Mean_statistics".stay_id and "SaO2_statistics".date = "Systemic Mean_statistics".date
	FULL JOIN "Compliance_statistics" ON "SaO2_statistics".stay_id = "Compliance_statistics".stay_id and "SaO2_statistics".date = "Compliance_statistics".date
	FULL JOIN "FiO2_statistics" ON "SaO2_statistics".stay_id = "FiO2_statistics".stay_id and "SaO2_statistics".date = "FiO2_statistics".date
	FULL JOIN "Minute Ventilation_statistics" ON "SaO2_statistics".stay_id = "Minute Ventilation_statistics".stay_id and "SaO2_statistics".date = "Minute Ventilation_statistics".date
	FULL JOIN "Mean Airway Pressure_statistics" ON "SaO2_statistics".stay_id = "Mean Airway Pressure_statistics".stay_id and "SaO2_statistics".date = "Mean Airway Pressure_statistics".date
	FULL JOIN "Peak Airway Pressure_statistics" ON "SaO2_statistics".stay_id = "Peak Airway Pressure_statistics".stay_id and "SaO2_statistics".date = "Peak Airway Pressure_statistics".date
	FULL JOIN "PEEP_statistics" ON "SaO2_statistics".stay_id = "PEEP_statistics".stay_id and "SaO2_statistics".date = "PEEP_statistics".date
	FULL JOIN "PC mode_statistics" ON "SaO2_statistics".stay_id = "PC mode_statistics".stay_id and "SaO2_statistics".date = "PC mode_statistics".date
	FULL JOIN "Pressure Support_statistics" ON "SaO2_statistics".stay_id = "Pressure Support_statistics".stay_id and "SaO2_statistics".date = "Pressure Support_statistics".date
	FULL JOIN "Plateau_statistics" ON "SaO2_statistics".stay_id = "Plateau_statistics".stay_id and "SaO2_statistics".date = "Plateau_statistics".date
	FULL JOIN "Tidal Volume_statistics" ON "SaO2_statistics".stay_id = "Tidal Volume_statistics".stay_id and "SaO2_statistics".date = "Tidal Volume_statistics".date
	FULL JOIN "Respiratory Rate_statistics" ON "SaO2_statistics".stay_id = "Respiratory Rate_statistics".stay_id and "SaO2_statistics".date = "Respiratory Rate_statistics".date
	FULL JOIN "ROXindex_statistics" ON "SaO2_statistics".stay_id = "ROXindex_statistics".stay_id and "SaO2_statistics".date = "ROXindex_statistics".date
	FULL JOIN "Daily RSBI_statistics" ON "SaO2_statistics".stay_id = "Daily RSBI_statistics".stay_id and "SaO2_statistics".date = "Daily RSBI_statistics".date
	FULL JOIN "Unable RSBI_statistics" ON "SaO2_statistics".stay_id = "Unable RSBI_statistics".stay_id and "SaO2_statistics".date = "Unable RSBI_statistics".date
	FULL JOIN "RASS_statistics" ON "SaO2_statistics".stay_id = "RASS_statistics".stay_id and "SaO2_statistics".date = "RASS_statistics".date
)

,final2 as 
(
	SELECT
		coalesce(stay_id_0,stay_id_1,stay_id_2,stay_id_3,stay_id_4,stay_id_5,stay_id_6,stay_id_7,stay_id_8,stay_id_9,stay_id_10,stay_id_11,stay_id_12,stay_id_13,stay_id_14,stay_id_15,stay_id_16,stay_id_17,stay_id_18,stay_id_19,stay_id_20) as stay_id,
		coalesce(date_0,date_1,date_2,date_3,date_4,date_5,date_6,date_7,date_8,date_9,date_10,date_11,date_12,date_13,date_14,date_15,date_16,date_17,date_18,date_19,date_20) as date,
		MAX("max SaO2") as "max SaO2",
		MAX("min SaO2") as "min SaO2",
		MAX("first SaO2") as "first SaO2",
		MAX("last SaO2") as "last SaO2",
		MAX("avg SaO2") as "avg SaO2",
		MAX("max Respiration") as "max Respiration",
		MAX("min Respiration") as "min Respiration",
		MAX("first Respiration") as "first Respiration",
		MAX("last Respiration") as "last Respiration",
		MAX("avg Respiration") as "avg Respiration",
		MAX("max Heart Rate") as "max Heart Rate",
		MAX("min Heart Rate") as "min Heart Rate",
		MAX("first Heart Rate") as "first Heart Rate",
		MAX("last Heart Rate") as "last Heart Rate",
		MAX("avg Heart Rate") as "avg Heart Rate",
		MAX("max Systemic Systolic") as "max Systemic Systolic",
		MAX("min Systemic Systolic") as "min Systemic Systolic",
		MAX("first Systemic Systolic") as "first Systemic Systolic",
		MAX("last Systemic Systolic") as "last Systemic Systolic",
		MAX("avg Systemic Systolic") as "avg Systemic Systolic",
		MAX("max Systemic Diastolic") as "max Systemic Diastolic",
		MAX("min Systemic Diastolic") as "min Systemic Diastolic",
		MAX("first Systemic Diastolic") as "first Systemic Diastolic",
		MAX("last Systemic Diastolic") as "last Systemic Diastolic",
		MAX("avg Systemic Diastolic") as "avg Systemic Diastolic",
		MAX("max Systemic Mean") as "max Systemic Mean",
		MAX("min Systemic Mean") as "min Systemic Mean",
		MAX("first Systemic Mean") as "first Systemic Mean",
		MAX("last Systemic Mean") as "last Systemic Mean",
		MAX("avg Systemic Mean") as "avg Systemic Mean",
		MAX("max Compliance") as "max Compliance",
		MAX("min Compliance") as "min Compliance",
		MAX("first Compliance") as "first Compliance",
		MAX("last Compliance") as "last Compliance",
		MAX("avg Compliance") as "avg Compliance",
		MAX("max FiO2") as "max FiO2",
		MAX("min FiO2") as "min FiO2",
		MAX("first FiO2") as "first FiO2",
		MAX("last FiO2") as "last FiO2",
		MAX("avg FiO2") as "avg FiO2",
		MAX("max Minute Ventilation") as "max Minute Ventilation",
		MAX("min Minute Ventilation") as "min Minute Ventilation",
		MAX("first Minute Ventilation") as "first Minute Ventilation",
		MAX("last Minute Ventilation") as "last Minute Ventilation",
		MAX("avg Minute Ventilation") as "avg Minute Ventilation",
		MAX("max Mean Airway Pressure") as "max Mean Airway Pressure",
		MAX("min Mean Airway Pressure") as "min Mean Airway Pressure",
		MAX("first Mean Airway Pressure") as "first Mean Airway Pressure",
		MAX("last Mean Airway Pressure") as "last Mean Airway Pressure",
		MAX("avg Mean Airway Pressure") as "avg Mean Airway Pressure",
		MAX("max Peak Airway Pressure") as "max Peak Airway Pressure",
		MAX("min Peak Airway Pressure") as "min Peak Airway Pressure",
		MAX("first Peak Airway Pressure") as "first Peak Airway Pressure",
		MAX("last Peak Airway Pressure") as "last Peak Airway Pressure",
		MAX("avg Peak Airway Pressure") as "avg Peak Airway Pressure",
		MAX("max PEEP") as "max PEEP",
		MAX("min PEEP") as "min PEEP",
		MAX("first PEEP") as "first PEEP",
		MAX("last PEEP") as "last PEEP",
		MAX("avg PEEP") as "avg PEEP",
		MAX("max PC mode") as "max PC mode",
		MAX("min PC mode") as "min PC mode",
		MAX("first PC mode") as "first PC mode",
		MAX("last PC mode") as "last PC mode",
		MAX("avg PC mode") as "avg PC mode",
		MAX("max Pressure Support") as "max Pressure Support",
		MAX("min Pressure Support") as "min Pressure Support",
		MAX("first Pressure Support") as "first Pressure Support",
		MAX("last Pressure Support") as "last Pressure Support",
		MAX("avg Pressure Support") as "avg Pressure Support",
		MAX("max Plateau") as "max Plateau",
		MAX("min Plateau") as "min Plateau",
		MAX("first Plateau") as "first Plateau",
		MAX("last Plateau") as "last Plateau",
		MAX("avg Plateau") as "avg Plateau",
		MAX("max Tidal Volume") as "max Tidal Volume",
		MAX("min Tidal Volume") as "min Tidal Volume",
		MAX("first Tidal Volume") as "first Tidal Volume",
		MAX("last Tidal Volume") as "last Tidal Volume",
		MAX("avg Tidal Volume") as "avg Tidal Volume",
		MAX("max Respiratory Rate") as "max Respiratory Rate",
		MAX("min Respiratory Rate") as "min Respiratory Rate",
		MAX("first Respiratory Rate") as "first Respiratory Rate",
		MAX("last Respiratory Rate") as "last Respiratory Rate",
		MAX("avg Respiratory Rate") as "avg Respiratory Rate",
		MAX("max ROXindex") as "max ROXindex",
		MAX("min ROXindex") as "min ROXindex",
		MAX("first ROXindex") as "first ROXindex",
		MAX("last ROXindex") as "last ROXindex",
		MAX("avg ROXindex") as "avg ROXindex",
		MAX("max Daily RSBI") as "max Daily RSBI",
		MAX("min Daily RSBI") as "min Daily RSBI",
		MAX("first Daily RSBI") as "first Daily RSBI",
		MAX("last Daily RSBI") as "last Daily RSBI",
		MAX("avg Daily RSBI") as "avg Daily RSBI",
		MAX("max Unable RSBI") as "max Unable RSBI",
		MAX("min Unable RSBI") as "min Unable RSBI",
		MAX("first Unable RSBI") as "first Unable RSBI",
		MAX("last Unable RSBI") as "last Unable RSBI",
		MAX("avg Unable RSBI") as "avg Unable RSBI",
		MAX("max RASS") as "max RASS",
		MAX("min RASS") as "min RASS",
		MAX("first RASS") as "first RASS",
		MAX("last RASS") as "last RASS",
		MAX("avg RASS") as "avg RASS"
	FROM
		final
	GROUP BY
		stay_id,date
)
select * from final2 
order by stay_id,date