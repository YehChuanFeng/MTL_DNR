DROP table IF EXISTS data_9.vent_with_time; 
create table data_9.vent_with_time AS

/*
InvasiveVent
tracheostomy
NonInvasiveVent
SupplementalOxygen
HFNC
*/

with a as 
(
	SELECT 
		final_fusion.stay_id,
		final_fusion.date,
		final_fusion."avg PEEP" as "PEEP",
		final_fusion."avg FiO2" as "FiO2",
		case
			when ventilation_status = 'InvasiveVent' then 1 else 0
		end as "InvasiveVent"
	FROM 
		data_9.final_fusion as final_fusion
	LEFT JOIN
		data_9.invasivevent as invasivevent
	ON
	   (invasivevent.vent_stay_id = final_fusion.stay_id and final_fusion.date >=invasivevent.start_date) and
	   (invasivevent.vent_stay_id = final_fusion.stay_id and final_fusion.date <= invasivevent.end_date) 
)
, b as 
(
	SELECT
		a.stay_id,
		a.date,
		a."PEEP",
		a."FiO2",
		"InvasiveVent",
		case
			when ventilation_status2 = 'tracheostomy' then 1 else 0
		end as "tracheostomy"
	FROM
		a
	LEFT JOIN
		data_9.tracheostomy
	ON
	   (tracheostomy.vent_stay_id = a.stay_id and a.date >=tracheostomy.start_date) and
	   (tracheostomy.vent_stay_id = a.stay_id and a.date <= tracheostomy.end_date) 

)
, c as 
(
	SELECT
		b.stay_id,
		b.date,
		b."PEEP",
		b."FiO2",
		"InvasiveVent",
		"tracheostomy",
		case
			when ventilation_status2 = 'NonInvasiveVent' then 1 else 0
		end as "NonInvasiveVent"
	FROM
		b
	LEFT JOIN
		data_9.NonInvasiveVent
	ON
	   (NonInvasiveVent.vent_stay_id = b.stay_id and b.date >=NonInvasiveVent.start_date) and
	   (NonInvasiveVent.vent_stay_id = b.stay_id and b.date <= NonInvasiveVent.end_date) 

)
, d as 
(
	SELECT
		c.stay_id,
		c.date,
		c."PEEP",
		c."FiO2",
		"InvasiveVent",
		"tracheostomy",
		"NonInvasiveVent",
		case
			when ventilation_status2 = 'SupplementalOxygen' then 1 else 0
		end as "SupplementalOxygen"
	FROM
		c
	LEFT JOIN
		data_9.SupplementalOxygen
	ON
	   (SupplementalOxygen.vent_stay_id = c.stay_id and c.date >= SupplementalOxygen.start_date) and
	   (SupplementalOxygen.vent_stay_id = c.stay_id and c.date <= SupplementalOxygen.end_date) 
)
, e as 
(
	SELECT
		d.stay_id,
		d.date,
		d."PEEP",
		d."FiO2",
		"InvasiveVent",
		"tracheostomy",
		"NonInvasiveVent",
		"SupplementalOxygen",
		case
			when ventilation_status2 = 'HFNC' then 1 else 0
		end as "HFNC"
	FROM
		d
	LEFT JOIN
		data_9.HFNC
	ON
	   (HFNC.vent_stay_id = d.stay_id and d.date >= HFNC.start_date) and
	   (HFNC.vent_stay_id = d.stay_id and d.date <= HFNC.end_date) 
)

--SBT
, f as 
(
	SELECT
		e.stay_id,
		e.date,
		MAX(e."PEEP") as "PEEP",
		MAX(e."FiO2") as "FiO2",
		MAX("InvasiveVent") as "InvasiveVent",
		MAX("tracheostomy") as "tracheostomy",
		MAX("NonInvasiveVent") as "NonInvasiveVent",
		MAX("SupplementalOxygen") as "SupplementalOxygen",
		MAX("HFNC") as "HFNC",
		MAX(COALESCE("SBT Started",0)) as "SBT Started",
		MAX(COALESCE("SBT Successfully Completed",0)) as "SBT Successfully Completed"
		
	FROM
		e
	LEFT JOIN
		data_9.sbt
	ON
	   (sbt.stay_id = e.stay_id and sbt.date = e.date)
	GROUP BY
		e.stay_id,e.date
)
--tubation
, g as 
(
	SELECT
		f.stay_id,
		f.date,
		MAX("PEEP") as "PEEP",
		MAX("FiO2") as "FiO2",
		MAX("InvasiveVent") as "InvasiveVent",
		MAX("tracheostomy") as "tracheostomy",
		MAX("NonInvasiveVent") as "NonInvasiveVent",
		MAX("SupplementalOxygen") as "SupplementalOxygen",
		MAX("HFNC") as "HFNC",
		MAX(COALESCE("SBT Started",0)) as "SBT Started",
		MAX(COALESCE("SBT Successfully Completed",0)) as "SBT Successfully Completed",
		MAX(COALESCE("intubation",0)) as "intubation",
		MAX(COALESCE("extubation",0)) as "extubation"
		
	FROM
		f
	FULL JOIN
		data_9.tubation as tubation
	ON
	   (tubation.stay_id = f.stay_id and tubation.date = f.date)
	GROUP BY
		f.stay_id,f.date
)
select * from g
order by stay_id,date
