DROP table IF EXISTS data_9.lab_static; 
create table data_9.lab_static AS

with lab as 
(
	SELECT 
		  lab.subject_id
		, lab.charttime
		, AVG(case when itemid in (51002) then valuenum else null end) as "Troponin - I" 
		, AVG(case when itemid in (51003) then valuenum else null end) as "Troponin - T"
		, AVG(case when itemid in (50924) then valuenum else null end) as "Ferritin"
		, AVG(case when itemid in (50998) then valuenum else null end) as "Transferrin"
		, AVG(case when itemid in (50889) then valuenum else null end) as "CRP"
		, AVG(case when itemid in (51214) then valuenum else null end) as "Fibrinogen"
		, AVG(case when itemid in (50904,50903) then valuenum else null end) as "HDL"
		, AVG(case when itemid in (50905,50906)  then valuenum else null end) as "LDL"
		, AVG(case when itemid in (50907,50903) then valuenum else null end) as "Total Cholesterol"
		, AVG(case when itemid in (50883) then valuenum else null end) as "Direct Bilirubin"
		, AVG(case when itemid in (50813,50954,51054) and valuenum < 1000 then valuenum else null end) as "Lactate"
		, AVG(case when itemid in (50954,51054) and valuenum < 2500 then valuenum else null end) as "LDH"
		, AVG(case when itemid in (50844,51036,51055,50956) then valuenum else null end) as "Lipase"
		, AVG(case when itemid in (50867,50836,51026,51047,51072,51073,51020) then valuenum else null end) as "Amylase"
		, AVG(case when itemid in (50910) then valuenum else null end) as "CPK"
		, AVG(case when itemid in (50911) then valuenum else null end) as "CPK-MB"
		--, MAX(case when itemid in (-1) then valuenum else null end) as "CPK-MB_INDEX"  
		, AVG(case when itemid in (50963) then valuenum else null end) as "BNP"
		, AVG(case when itemid in (51275,52923) then valuenum else null end) as "PTT"      
		, AVG(case when itemid in (-1) then valuenum else null end) as "PTT_Ratio" 

		, AVG(case when itemid in (50952) then valuenum else null end) as "Fe"
		, AVG(case when itemid in (50953) then valuenum else null end) as "TIBC"
		, AVG(case when itemid in (-1) then valuenum else null end) as "Fe/TIBC Ratio"

		, AVG(case when itemid in (50964) then valuenum else null end) as "Serum Osmolality"
		, AVG(case when itemid in (50993) then valuenum else null end) as "TSH"
		, AVG(case when itemid in (51001) then valuenum else null end) as "T3"
		, AVG(case when itemid in (50994,50896,50995) then valuenum else null end) as "T4"
		, AVG(case when itemid in (50995) then valuenum else null end) as "Free T4"
		, AVG(case when itemid in (50808,51066,51029,50893,51077) then valuenum else null end) as "Ionized Calcium"
		, AVG(case when itemid in (51000,51060,50850) then valuenum else null end) as "Triglycerides"
		, AVG(case when itemid in (50909,227463,1638) then valuenum else null end) as "Cortisol"
		, AVG(case when itemid in (51007,51505,51105) then valuenum else null end) as "Uric Acid"
		, AVG(case when itemid in (50866) then valuenum else null end) as "Ammonia"
		, AVG(case when itemid in (51010) then valuenum else null end) as "Vitamin B12"
	FROM 
		mimiciv_hosp.labevents as lab
	WHERE 
		lab.itemid in 
		(

			51002
			,51003
			,50924
			,50998
			,-1
			,50889
			,51214
			,50904,50903
			,50905,50906
			,50907,50903
			,50883
			,50813,50954,51054
			,50954,51054
			,50844,51036,51055,50956
			,50867,50836,51026,51047,51072,51073,51020
			,50910
			,50911
			,-1
			,50963
			,51275,52923
			,-1
			,50952
			,50953
			,-1
			,50964
			,50993
			,51001
			,50994,50896,50995
			,50995
			,50808,51066,51029,50893,51077
			,51000,51060,50850
			,50909,227463,1638
			,51007,51505,51105
			,50866
			,51010
		) and valuenum IS NOT NULL
	GROUP BY 
		lab.subject_id,lab.charttime
)

SELECT * FROM lab

