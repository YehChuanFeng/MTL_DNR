DROP TABLE IF EXISTS data_9.lab_TimeSeries; 
CREATE TABLE data_9.lab_TimeSeries AS

with a as 
(
	SELECT 
	  	subject_id,
	  	date,
	  	hour,
	
	  	"Platelets x1000",
		FIRST_VALUE("Platelets x1000") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Platelets x1000",
		FIRST_VALUE("Platelets x1000") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Platelets x1000",


		"WBC x1000",
		FIRST_VALUE("WBC x1000") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first WBC x1000",
		FIRST_VALUE("WBC x1000") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last WBC x1000",


		"Hgb",
		FIRST_VALUE("Hgb") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Hgb",
		FIRST_VALUE("Hgb") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Hgb",


		"Albumin",
		FIRST_VALUE("Albumin") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Albumin",
		FIRST_VALUE("Albumin") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Albumin",


		"Total Protein",
		FIRST_VALUE("Total Protein") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Total Protein",
		FIRST_VALUE("Total Protein") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Total Protein",


		"Total Bilirubin",
		FIRST_VALUE("Total Bilirubin") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Total Bilirubin",
		FIRST_VALUE("Total Bilirubin") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Total Bilirubin",


		"PO2",
		FIRST_VALUE("PO2") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first PO2",
		FIRST_VALUE("PO2") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last PO2",


		"PaCO2",
		FIRST_VALUE("PaCO2") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first PaCO2",
		FIRST_VALUE("PaCO2") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last PaCO2",


		"Glucose",
		FIRST_VALUE("Glucose") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Glucose",
		FIRST_VALUE("Glucose") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Glucose",


		"BUN",
		FIRST_VALUE("BUN") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first BUN",
		FIRST_VALUE("BUN") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last BUN",


		"pH",
		FIRST_VALUE("pH") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first pH",
		FIRST_VALUE("pH") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last pH",


		"Sodium",
		FIRST_VALUE("Sodium") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Sodium",
		FIRST_VALUE("Sodium") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Sodium",


		"Potassium",
		FIRST_VALUE("Potassium") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Potassium",
		FIRST_VALUE("Potassium") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Potassium",


		"Magnesium",
		FIRST_VALUE("Magnesium") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Magnesium",
		FIRST_VALUE("Magnesium") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Magnesium",


		"Calcium",
		FIRST_VALUE("Calcium") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Calcium",
		FIRST_VALUE("Calcium") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Calcium",


		"Chloride",
		FIRST_VALUE("Chloride") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Chloride",
		FIRST_VALUE("Chloride") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Chloride",


		"creatinine",
		FIRST_VALUE("creatinine") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first creatinine",
		FIRST_VALUE("creatinine") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last creatinine",


		"HCO3",
		FIRST_VALUE("HCO3") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first HCO3",
		FIRST_VALUE("HCO3") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last HCO3",


		"Phosphate",
		FIRST_VALUE("Phosphate") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Phosphate",
		FIRST_VALUE("Phosphate") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Phosphate",


		"Alkaline Phos.",
		FIRST_VALUE("Alkaline Phos.") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first Alkaline Phos.",
		FIRST_VALUE("Alkaline Phos.") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last Alkaline Phos.",


		"AST (SGOT)",
		FIRST_VALUE("AST (SGOT)") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first AST (SGOT)",
		FIRST_VALUE("AST (SGOT)") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last AST (SGOT)",


		"ALT (SGPT)",
		FIRST_VALUE("ALT (SGPT)") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first ALT (SGPT)",
		FIRST_VALUE("ALT (SGPT)") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last ALT (SGPT)",


		"PT-INR",
		FIRST_VALUE("PT-INR") OVER (PARTITION BY subject_id, date ORDER BY date,hour) AS  "first PT-INR",
		FIRST_VALUE("PT-INR") OVER (PARTITION BY subject_id, date ORDER BY date,hour DESC) AS "last PT-INR"
	
	FROM	
		data_9.lab_timeseries_hour
	ORDER BY
		subject_id,date,hour	
)

, b as 
(
	SELECT
		subject_id,date,
		AVG("Platelets x1000") as "avg Platelets x1000",
		Min("Platelets x1000") as "min Platelets x1000",
		Max("Platelets x1000") as "max Platelets x1000",
		AVG("first Platelets x1000") as "first Platelets x1000",
		AVG("last Platelets x1000") as "last Platelets x1000",


		AVG("WBC x1000") as "avg WBC x1000",
		Min("WBC x1000") as "min WBC x1000",
		Max("WBC x1000") as "max WBC x1000",
		AVG("first WBC x1000") as "first WBC x1000",
		AVG("last WBC x1000") as "last WBC x1000",


		AVG("Hgb") as "avg Hgb",
		Min("Hgb") as "min Hgb",
		Max("Hgb") as "max Hgb",
		AVG("first Hgb") as "first Hgb",
		AVG("last Hgb") as "last Hgb",


		AVG("Albumin") as "avg Albumin",
		Min("Albumin") as "min Albumin",
		Max("Albumin") as "max Albumin",
		AVG("first Albumin") as "first Albumin",
		AVG("last Albumin") as "last Albumin",


		AVG("Total Protein") as "avg Total Protein",
		Min("Total Protein") as "min Total Protein",
		Max("Total Protein") as "max Total Protein",
		AVG("first Total Protein") as "first Total Protein",
		AVG("last Total Protein") as "last Total Protein",


		AVG("Total Bilirubin") as "avg Total Bilirubin",
		Min("Total Bilirubin") as "min Total Bilirubin",
		Max("Total Bilirubin") as "max Total Bilirubin",
		AVG("first Total Bilirubin") as "first Total Bilirubin",
		AVG("last Total Bilirubin") as "last Total Bilirubin",


		AVG("PO2") as "avg PO2",
		Min("PO2") as "min PO2",
		Max("PO2") as "max PO2",
		AVG("first PO2") as "first PO2",
		AVG("last PO2") as "last PO2",


		AVG("PaCO2") as "avg PaCO2",
		Min("PaCO2") as "min PaCO2",
		Max("PaCO2") as "max PaCO2",
		AVG("first PaCO2") as "first PaCO2",
		AVG("last PaCO2") as "last PaCO2",


		AVG("Glucose") as "avg Glucose",
		Min("Glucose") as "min Glucose",
		Max("Glucose") as "max Glucose",
		AVG("first Glucose") as "first Glucose",
		AVG("last Glucose") as "last Glucose",


		AVG("BUN") as "avg BUN",
		Min("BUN") as "min BUN",
		Max("BUN") as "max BUN",
		AVG("first BUN") as "first BUN",
		AVG("last BUN") as "last BUN",


		AVG("pH") as "avg pH",
		Min("pH") as "min pH",
		Max("pH") as "max pH",
		AVG("first pH") as "first pH",
		AVG("last pH") as "last pH",


		AVG("Sodium") as "avg Sodium",
		Min("Sodium") as "min Sodium",
		Max("Sodium") as "max Sodium",
		AVG("first Sodium") as "first Sodium",
		AVG("last Sodium") as "last Sodium",


		AVG("Potassium") as "avg Potassium",
		Min("Potassium") as "min Potassium",
		Max("Potassium") as "max Potassium",
		AVG("first Potassium") as "first Potassium",
		AVG("last Potassium") as "last Potassium",


		AVG("Magnesium") as "avg Magnesium",
		Min("Magnesium") as "min Magnesium",
		Max("Magnesium") as "max Magnesium",
		AVG("first Magnesium") as "first Magnesium",
		AVG("last Magnesium") as "last Magnesium",


		AVG("Calcium") as "avg Calcium",
		Min("Calcium") as "min Calcium",
		Max("Calcium") as "max Calcium",
		AVG("first Calcium") as "first Calcium",
		AVG("last Calcium") as "last Calcium",


		AVG("Chloride") as "avg Chloride",
		Min("Chloride") as "min Chloride",
		Max("Chloride") as "max Chloride",
		AVG("first Chloride") as "first Chloride",
		AVG("last Chloride") as "last Chloride",


		AVG("creatinine") as "avg creatinine",
		Min("creatinine") as "min creatinine",
		Max("creatinine") as "max creatinine",
		AVG("first creatinine") as "first creatinine",
		AVG("last creatinine") as "last creatinine",


		AVG("HCO3") as "avg HCO3",
		Min("HCO3") as "min HCO3",
		Max("HCO3") as "max HCO3",
		AVG("first HCO3") as "first HCO3",
		AVG("last HCO3") as "last HCO3",


		AVG("Phosphate") as "avg Phosphate",
		Min("Phosphate") as "min Phosphate",
		Max("Phosphate") as "max Phosphate",
		AVG("first Phosphate") as "first Phosphate",
		AVG("last Phosphate") as "last Phosphate",


		AVG("Alkaline Phos.") as "avg Alkaline Phos.",
		Min("Alkaline Phos.") as "min Alkaline Phos.",
		Max("Alkaline Phos.") as "max Alkaline Phos.",
		AVG("first Alkaline Phos.") as "first Alkaline Phos.",
		AVG("last Alkaline Phos.") as "last Alkaline Phos.",


		AVG("AST (SGOT)") as "avg AST (SGOT)",
		Min("AST (SGOT)") as "min AST (SGOT)",
		Max("AST (SGOT)") as "max AST (SGOT)",
		AVG("first AST (SGOT)") as "first AST (SGOT)",
		AVG("last AST (SGOT)") as "last AST (SGOT)",


		AVG("ALT (SGPT)") as "avg ALT (SGPT)",
		Min("ALT (SGPT)") as "min ALT (SGPT)",
		Max("ALT (SGPT)") as "max ALT (SGPT)",
		AVG("first ALT (SGPT)") as "first ALT (SGPT)",
		AVG("last ALT (SGPT)") as "last ALT (SGPT)",


		AVG("PT-INR") as "avg PT-INR",
		Min("PT-INR") as "min PT-INR",
		Max("PT-INR") as "max PT-INR",
		AVG("first PT-INR") as "first PT-INR",
		AVG("last PT-INR") as "last PT-INR"
	FROM
		a
	Group By
		subject_id,date
)

select * from b
