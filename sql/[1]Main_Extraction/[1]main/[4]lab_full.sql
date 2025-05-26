DROP table IF EXISTS data_9.lab_TimeSeries_hour;  
create table data_9.lab_TimeSeries_hour AS


with a as 
(
	select 
		subject_id
		--,lab.charttime
		, to_date(charttime::text, 'yyyy-mm-dd') as date
		, DATE_PART('hour', charttime) AS hour

		, AVG(case when itemid in (51265) then valuenum else null end) as "Platelets x1000"
		, AVG(case when itemid in (51301,51516,51300) then valuenum else null end) as "WBC x1000"
		, AVG(case when itemid in (1165,51222,50811,50852,50855) then valuenum else null end) as "Hgb"
		, AVG(CASE WHEN itemid = 50862 THEN valuenum ELSE NULL END) AS "Albumin"
		, AVG(CASE WHEN itemid = 50976 THEN valuenum ELSE NULL END) AS "Total Protein"
		, AVG(case when itemid in (50885,1538,848,225690) then valuenum else null end) as "Total Bilirubin"
		, AVG(case when itemid in (50821) then valuenum else null end) as "PO2"  
		, AVG(case when itemid in (50818) then valuenum else null end) as "PaCO2" 
		, AVG(CASE WHEN itemid = 50931 THEN valuenum ELSE NULL END) AS "Glucose"  
		, AVG(CASE WHEN itemid = 51006 THEN valuenum ELSE NULL END) AS "BUN"
		, AVG(case when itemid in (7459,50820,51491,3839,1673,50831,51094,780,1126,223830,4753,4202,860,220274) then valuenum else null end) as "pH"
		, AVG(CASE WHEN itemid = 50983 THEN valuenum ELSE NULL END) AS "Sodium"
		, AVG(CASE WHEN itemid = 50971 THEN valuenum ELSE NULL END) AS "Potassium"
		, AVG(case when itemid in (44088,40645,50960,821,1532,220635) then valuenum else null end) as "Magnesium"
		, AVG(CASE WHEN itemid = 50893 THEN valuenum ELSE NULL END) AS "Calcium"
		, AVG(CASE WHEN itemid = 50902 THEN valuenum ELSE NULL END) AS "Chloride"
		, AVG(CASE WHEN itemid = 50912 THEN valuenum ELSE NULL END) AS "creatinine"
		, AVG(case when itemid in (812,50882,227443,51076,50803) then valuenum else null end) as "HCO3"
		, AVG(case when itemid in (50970) then valuenum else null end) as "Phosphate"
		, AVG(case when itemid in (50863) then valuenum else null end) as "Alkaline Phos."
		, AVG(case when itemid in (50878) then valuenum else null end) as "AST (SGOT)"
		, AVG(case when itemid in (50861) then valuenum else null end) as "ALT (SGPT)"
		, AVG(case when itemid in (51237,51274,815,824,1530,1286,227467,227465) then valuenum else null end) as "PT-INR"
	
	FROM
		mimiciv_hosp.labevents as lab
	WHERE 
		lab.itemid in 
		(
			 51265
			,51301,51516,51300
			,1165,51222,50811,50852,50855
			,50862
			,50976
			,50885,1538,848,225690
			,50821
			,50818
			,50931
			,51006
			,7459,50820,51491,3839,1673,50831,51094,780,1126,223830,4753,4202,860,220274
			,50983
			,50971
			,44088,40645,50960,821,1532,220635
			,50893
			,50902
			,50912
			,812,50882,227443,51076,50803
			,50970
			,50863
			,50878
			,50861
			,51237,51274,815,824,1530,1286,227467,227465

		) 
	GROUP BY 
		subject_id,date,hour
)

select * from a