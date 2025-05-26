
WITH cohort AS
(
	SELECT 
		stay_id as select_id
	FROM 
		data_9.icu_detail
	WHERE
		hospstay_seq = 1 and icustay_seq = 1 and los_icu >= 4 and age >=18
)


SELECT 
	* 
FROM 
	data_9.final_fusion_with_vent_plus,cohort
WHERE
	data_9.final_fusion_with_vent_plus.stay_id = cohort.select_id
ORDER BY stay_id,date
