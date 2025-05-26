DROP TABLE IF EXISTS data_9.vent; 
CREATE TABLE data_9.vent AS

--要找的時間區段
WITH table1 as 
(
	select * FROM data_9.ventilation
	where ventilation_status = 'InvasiveVent'
)
--要找的測量值
,table2 AS
(
	SELECT
		stay_id,
		charttime,
		CASE 
			WHEN itemid = 223835 AND valuenum IS NOT NULL 
			THEN 
				CASE
					WHEN valuenum >= 0.20 AND valuenum <= 1
						THEN valuenum * 100
					-- improperly input data - looks like O2 flow in litres
					WHEN valuenum > 1 AND valuenum < 20
						THEN NULL
					WHEN valuenum >= 20 AND valuenum <= 121
						THEN valuenum
					ELSE NULL
				END
		END AS "FiO2",
		
		CASE
		 	WHEN itemid in (220339, 224700)
        	THEN
				CASE
					WHEN valuenum > 100 THEN NULL
					WHEN valuenum < 0 THEN NULL
					ELSE valuenum
				END
        END AS "PEEP"

	FROM 
		mimiciv_icu.chartevents
	WHERE
	    itemid in (223835,224700,220339)
)

-- 全時段保留  以下這段有跟沒有依樣   之前是用inner join 來只篩特定時間的值
SELECT
  t2.stay_id,
  t2.charttime,
  t1.starttime,
  t1.endtime,
  t2."FiO2",
  t2."PEEP"
FROM
  table2 t2
LEFT JOIN
  table1 t1
ON
  t2.stay_id = t1.stay_id
  AND t2.charttime BETWEEN t1.starttime AND t1.endtime;