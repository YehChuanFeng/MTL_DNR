DROP table IF EXISTS data_9.final_static; 
create table data_9.final_static AS

with lab as 
(
	SELECT 
		subject_id as subject_id_lab,
		AVG("Troponin - I") as "Troponin - I",
		AVG("Troponin - T") as "Troponin - T",
		AVG("Ferritin") as "Ferritin",
		AVG("Transferrin") as "Transferrin",

		AVG("CRP") as "CRP",
		AVG("Fibrinogen") as "Fibrinogen",
		AVG("HDL") as "HDL",
		AVG("LDL") as "LDL",
		AVG("Total Cholesterol") as "Total Cholesterol",
		AVG("Direct Bilirubin") as "Direct Bilirubin",
		AVG("Lactate") as "Lactate",
		AVG("LDH") as "LDH",
		AVG("Lipase") as "Lipase",
		AVG("Amylase") as "Amylase",
		AVG("CPK") as "CPK",
		AVG("CPK-MB") as "CPK-MB",
		--"CPK-MB_INDEX"  
		AVG("BNP") as "BNP",
		AVG("PTT") as "PTT",
		AVG("PTT_Ratio") as "PTT_Ratio", 
		AVG("Fe") as "Fe",
		AVG("TIBC") as "TIBC",
		AVG("Fe/TIBC Ratio") as "Fe/TIBC Ratio",  
		AVG("Serum Osmolality") as "Serum Osmolality",
		AVG("TSH") as "TSH",
		AVG("T3") as "T3",
		AVG("T4") as "T4",
		AVG("Free T4") as "Free T4",
		AVG("Ionized Calcium") as "Ionized Calcium",
		AVG("Triglycerides") as "Triglycerides",
		AVG("Cortisol") as "Cortisol",
		AVG("Uric Acid") as "Uric Acid",
		AVG("Ammonia") as "Ammonia",
		AVG("Vitamin B12") as "Vitamin B12"
	FROM 
		data_9.lab_static
	GROUP BY
		subject_id
	Order by subject_id
)

,diagnoses_0 as 
(
	SELECT
		stay_id as stay_id_diag,
		case when label = 'MI' then 1 else 0 end as "MI",
		case when label = 'CHF' then 1 else 0 end as "CHF",
		case when label = 'PVD' then 1 else 0 end as "PVD",
		case when label = 'CVD' then 1 else 0 end as "CVD",
		case when label = 'Dementia' then 1 else 0 end as "Dementia",
		case when label = 'CPD' then 1 else 0 end as "CPD",
		case when label = 'RD' then 1 else 0 end as "RD",
		case when label = 'PUD' then 1 else 0 end as "PUD",
		case when label = 'MLD' then 1 else 0 end as "MLD",
		case when label = 'DM_acute' then 1 else 0 end as "DM_acute",
		case when label = 'DM_Chronic' then 1 else 0 end as "DM_Chronic",
		case when label = 'Hemiplegia' then 1 else 0 end as "Hemiplegia",
		case when label = 'Renal' then 1 else 0 end as "Renal",
		case when label = 'Malignancy' then 1 else 0 end as "Malignancy",
		case when label = 'LD' then 1 else 0 end as "LD",
		case when label = 'MST' then 1 else 0 end as "MST",
		case when label = 'AIDS' then 1 else 0 end as "AIDS"
	
	FROM
		data_9.diagnoses_select
)
,diagnoses as 
(
	SELECT
		stay_id_diag,
		COALESCE(MAX("MI"), 0) as "MI",
		COALESCE(MAX("CHF"), 0) as "CHF",
		COALESCE(MAX("PVD"), 0) as "PVD",
		COALESCE(MAX("CVD"), 0) as "CVD",
		COALESCE(MAX("Dementia"), 0) as "Dementia",
		COALESCE(MAX("CPD"), 0) as "CPD",
		COALESCE(MAX("RD"), 0) as "RD",
		COALESCE(MAX("PUD"), 0) as "PUD",
		COALESCE(MAX("MLD"), 0) as "MLD",
		COALESCE(MAX("DM_acute"), 0) as "DM_acute",
		COALESCE(MAX("DM_Chronic"), 0) as "DM_Chronic",
		COALESCE(MAX("Hemiplegia"), 0) as "Hemiplegia",
		COALESCE(MAX("Renal"), 0) as "Renal",
		COALESCE(MAX("Malignancy"), 0) as "Malignancy",
		COALESCE(MAX("LD"), 0) as "LD",
		COALESCE(MAX("MST"), 0) as "MST",
		COALESCE(MAX("AIDS"), 0) as "AIDS"
	
	FROM
		diagnoses_0
	GROUP BY stay_id_diag
)
, target as 
(
	SELECT
		stay_id,
		gender,
		--dod,
		age,
		race,
		dnr,
		apsiii,
		------疾病---------------
		COALESCE("MI", 0) as "MI",
		COALESCE("CHF", 0) as "CHF",
		COALESCE("PVD", 0) as "PVD",
		COALESCE("CVD", 0) as "CVD",
		COALESCE("Dementia", 0) as "Dementia",
		COALESCE("CPD", 0) as "CPD",
		COALESCE("RD", 0) as "RD",
		COALESCE("PUD", 0) as "PUD",
		COALESCE("MLD", 0) as "MLD",
		COALESCE("DM_acute", 0) as "DM_acute",
		COALESCE("DM_Chronic", 0) as "DM_Chronic",
		COALESCE("Hemiplegia", 0) as "Hemiplegia",
		COALESCE("Renal", 0) as "Renal",
		COALESCE("Malignancy", 0) as "Malignancy",
		COALESCE("LD", 0) as "LD",
		COALESCE("MST", 0) as "MST",
		COALESCE("AIDS", 0) as "AIDS",
		------LAB---------------
		"Troponin - I", 
		"Troponin - T",
		"Ferritin",
		"Transferrin",
		"CRP",
		"Fibrinogen",
		"HDL",
		"LDL",
		"Total Cholesterol",
		"Direct Bilirubin",
		"Lactate",
		"LDH",
		"Lipase",
		"Amylase",
		"CPK",
		"CPK-MB",
		--"CPK-MB_INDEX"  
		"BNP",
		"PTT",
		"PTT_Ratio", 
		"Fe",
		"TIBC",
		"Fe/TIBC Ratio",
		"Serum Osmolality",
		"TSH",
		"T3",
		"T4",
		"Free T4",
		"Ionized Calcium",
		"Triglycerides",
		"Cortisol",
		"Uric Acid",
		"Ammonia",
		"Vitamin B12"
	FROM 
		lab
	LEFT JOIN
		data_9.icu_detail as detail
	ON detail.subject_id = lab.subject_id_lab
	
	LEFT JOIN
		diagnoses
	ON detail.stay_id = diagnoses.stay_id_diag
)

select *
from target

	