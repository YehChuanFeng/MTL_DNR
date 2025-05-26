DROP table IF EXISTS data_9.final_static_impute; 
create table data_9.final_static_impute AS
with rank_table as 
(
	SELECT
		--stay_id,
		--gender
		----dod,
		--, age
		--, AVG(race) as race
		AVG(dnr) as dnr
		, AVG(apsiii) as apsiii
		------疾病---------------
		, case when AVG("MI")>=0.5 then 1 else 0 end as "MI"
		, case when AVG("CHF")>=0.5 then 1 else 0 end  as "CHF"
		, case when AVG("PVD")>=0.5 then 1 else 0 end  as "PVD"
		, case when AVG("CVD")>=0.5 then 1 else 0 end  as "CVD"
		, case when AVG("Dementia")>=0.5 then 1 else 0 end  as "Dementia"
		, case when AVG("CPD")>=0.5 then 1 else 0 end  as "CPD"
		, case when AVG("RD")>=0.5 then 1 else 0 end  as "RD"
		, case when AVG("PUD")>=0.5 then 1 else 0 end  as "PUD"
		, case when AVG("MLD")>=0.5 then 1 else 0 end  as "MLD"
		, case when AVG("DM_acute")>=0.5 then 1 else 0 end  as "DM_acute"
		, case when AVG("DM_Chronic")>=0.5 then 1 else 0 end  as "DM_Chronic"
		, case when AVG("Hemiplegia")>=0.5 then 1 else 0 end  as "Hemiplegia"
		, case when AVG("Renal")>=0.5 then 1 else 0 end  as "Renal"
		, case when AVG("Malignancy")>=0.5 then 1 else 0 end  as "Malignancy"
		, case when AVG("LD")>=0.5 then 1 else 0 end  as "LD"
		, case when AVG("MST")>=0.5 then 1 else 0 end  as "MST"
		, case when AVG("AIDS")>=0.5 then 1 else 0 end  as "AIDS"
		------LAB---------------
		, AVG("Troponin - I") as "Troponin - I"
		, AVG("Troponin - T") as "Troponin - T"
		, AVG("Ferritin") as "Ferritin"
		, AVG("Transferrin") as "Transferrin"
		----找不到Prealbumin,
		, AVG("CRP") as "CRP"
		, AVG("Fibrinogen") as "Fibrinogen"
		, AVG("HDL") as "HDL"
		, AVG("LDL") as "LDL"
		, AVG("Total Cholesterol") as "Total Cholesterol"
		, AVG("Direct Bilirubin") as "Direct Bilirubin"
		, AVG("Lactate") as "Lactate"
		, AVG("LDH") as "LDH"
		, AVG("Lipase") as "Lipase"
		, AVG("Amylase") as "Amylase"
		, AVG("CPK") as "CPK"
		, AVG("CPK-MB") as "CPK-MB"
		----"CPK-MB_INDEX"  -----==> 不重要,
		, AVG("BNP") as "BNP"
		, AVG("PTT") as "PTT"
		, AVG("PTT_Ratio") as "PTT_Ratio"  -------找不到 ==>20230130用算的
		, AVG("Fe") as "Fe"
		, AVG("TIBC") as "TIBC"
		, AVG("Fe/TIBC Ratio") as "Fe/TIBC Ratio"-------用算的
		, AVG("Serum Osmolality") as "Serum Osmolality"
		, AVG("TSH") as "TSH"
		, AVG("T3") as "T3"
		, AVG("T4") as "T4"
		, AVG("Free T4") as "Free T4"
		, AVG("Ionized Calcium") as "Ionized Calcium"
		, AVG("Triglycerides") as "Triglycerides"
		, AVG("Cortisol") as "Cortisol"
		, AVG("Uric Acid") as "Uric Acid"
		, AVG("Ammonia") as "Ammonia"
		, AVG("Vitamin B12") as "Vitamin B12"
		, case 
			when age <=30 and gender = 'F'
				then 1
			when age>30 and age <=50 and gender = 'F'
				then 2
			WHEN age >50 and age <= 70 and gender = 'F'
				then 3
			WHEN age >70 and gender = 'F'
				then 4
			----
			when age <=30 and gender = 'M'
				then 5
			when age>30 and age <=50 and gender = 'M'
				then 6
			WHEN age >50 and age <= 70 and gender = 'M'
				then 7
			WHEN age >70 and gender = 'M'
				then 8
			end as age_rank
	FROM 
		all_patient.final_static
	GROUP BY
		age_rank
)
, static_addrank as 
(
	SELECT
		*
		, case 
			when age <=30 and gender = 'F'
				then 1
			when age>30 and age <=50 and gender = 'F'
				then 2
			WHEN age >50 and age <= 70 and gender = 'F'
				then 3
			WHEN age >70 and gender = 'F'
				then 4
			----
			when age <=30 and gender = 'M'
				then 5
			when age>30 and age <=50 and gender = 'M'
				then 6
			WHEN age >50 and age <= 70 and gender = 'M'
				then 7
			WHEN age >70 and gender = 'M'
				then 8
			end as age_rank
	from all_patient.final_static
)
, target as 
(
	select 
		stay_id,
		gender,
		--dod,
		age,
		race,
		COALESCE(b.dnr, a.dnr) as "dnr",
		COALESCE(b.apsiii, a.apsiii) as "apsiii",
		------疾病---------------
		COALESCE(b."MI", a."MI") as "MI",
		COALESCE(b."CHF", a."CHF") as "CHF",
		COALESCE(b."PVD", a."PVD") as "PVD",
		COALESCE(b."CVD", a."CVD") as "CVD",
		COALESCE(b."Dementia", a."Dementia") as "Dementia",
		COALESCE(b."CPD", a."CPD") as "CPD",
		COALESCE(b."RD", a."RD") as "RD",
		COALESCE(b."PUD", a."PUD") as "PUD",
		COALESCE(b."MLD", a."MLD") as "MLD",
		COALESCE(b."DM_acute", a."DM_acute") as "DM_acute",
		COALESCE(b."DM_Chronic", a."DM_Chronic") as "DM_Chronic",
		COALESCE(b."Hemiplegia", a."Hemiplegia") as "Hemiplegia",
		COALESCE(b."Renal", a."Renal") as "Renal",
		COALESCE(b."Malignancy", a."Malignancy") as "Malignancy",
		COALESCE(b."LD", a."LD") as "LD",
		COALESCE(b."MST", a."MST") as "MST",
		COALESCE(b."AIDS", a."AIDS") as "AIDS",
		------LAB---------------
		COALESCE(b."Troponin - I", a."Troponin - I") as "Troponin - I",
		COALESCE(b."Troponin - T", a."Troponin - T") as "Troponin - T",
		COALESCE(b."Ferritin", a."Ferritin") as "Ferritin",
		COALESCE(b."Transferrin", a."Transferrin") as "Transferrin",
		--找不到Prealbumin,
		COALESCE(b."CRP", a."CRP") as "CRP",
		COALESCE(b."Fibrinogen", a."Fibrinogen") as "Fibrinogen",
		COALESCE(b."HDL", a."HDL") as "HDL",
		COALESCE(b."LDL", a."LDL") as "LDL",
		COALESCE(b."Total Cholesterol", a."Total Cholesterol") as "Total Cholesterol",
		COALESCE(b."Direct Bilirubin", a."Direct Bilirubin") as "Direct Bilirubin",
		COALESCE(b."Lactate", a."Lactate") as "Lactate",
		COALESCE(b."LDH", a."LDH") as "LDH",
		COALESCE(b."Lipase", a."Lipase") as "Lipase",
		COALESCE(b."Amylase", a."Amylase") as "Amylase",
		COALESCE(b."CPK", a."CPK") as "CPK",
		COALESCE(b."CPK-MB", a."CPK-MB") as "CPK-MB",
		--"CPK-MB_INDEX"  -----==> 不重要,
		COALESCE(b."BNP", a."BNP") as "BNP",
		COALESCE(b."PTT", a."PTT") as "PTT",
		COALESCE(b."PTT_Ratio", a."PTT_Ratio") as "PTT_Ratio", -------找不到 ==>20230130用算的
		COALESCE(b."Fe", a."Fe")/COALESCE(b."TIBC", a."TIBC") as "Fe/TIBC Ratio",-------用算的
		COALESCE(b."Fe", a."Fe") as "Fe",
		COALESCE(b."TIBC", a."TIBC") as "TIBC",
		COALESCE(b."Serum Osmolality", a."Serum Osmolality") as "Serum_Osmolality",
		COALESCE(b."TSH", a."TSH") as "TSH",
		COALESCE(b."T3", a."T3") as "T3",
		COALESCE(b."T4", a."T4") as "T4",
		COALESCE(b."Free T4", a."Free T4") as "Free T4",
		COALESCE(b."Ionized Calcium", a."Ionized Calcium") as "Ionized Calcium",
		COALESCE(b."Triglycerides", a."Triglycerides") as "Triglycerides",
		COALESCE(b."Cortisol", a."Cortisol") as "Cortisol",
		COALESCE(b."Uric Acid", a."Uric Acid") as "Uric Acid",
		COALESCE(b."Ammonia", a."Ammonia") as "Ammonia",
		COALESCE(b."Vitamin B12" , a."Vitamin B12" ) as "Vitamin B12" 
	FROM
		static_addrank as b
	LEFT JOIN
		rank_table as a
	ON 
		b.age_rank = a.age_rank
)

select * from target
order by stay_id
