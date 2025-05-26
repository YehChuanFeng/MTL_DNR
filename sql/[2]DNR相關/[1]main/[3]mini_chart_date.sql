DROP table IF EXISTS pj_dnr.mini_chart_date;  
create table pj_dnr.mini_chart_date AS

/*
把要篩選的value都變成column
並聚合到以天為單位
*/
WITH mini_chart_date AS
(
	SELECT
		stay_id,
		DATE(charttime) AS date,
		itemid,
		value
	FROM 
		pj_dnr.mini_chart
	GROUP BY
		stay_id,DATE(charttime),itemid,value
)	

SELECT
	stay_id,
	date,
	MAX(CASE WHEN value = 'Anxiety' THEN 1 ELSE 0 END) AS "Anxiety",
	MAX(CASE WHEN value = 'Assess for anxiety, depression, or delirium which may contribute to pain and interfere with pain management' THEN 1 ELSE 0 END) AS "Assess for anxiety, depression, or delirium which may contribute to pain and interfere with pain management",
	MAX(CASE WHEN value = 'Asystole' THEN 1 ELSE 0 END) AS "Asystole",
	MAX(CASE WHEN value = 'Blood Transfusion' THEN 1 ELSE 0 END) AS "Blood Transfusion",
	MAX(CASE WHEN value = 'Consult to pastoral care, social services, palliative care, psychiatric services, case management as indicated' THEN 1 ELSE 0 END) AS "Consult to pastoral care, social services, palliative care, psychiatric services, case management as indicated",
	MAX(CASE WHEN value = 'DNAR (Do Not Attempt Resuscitation) [DNR]' THEN 1 ELSE 0 END) AS "DNAR (Do Not Attempt Resuscitation) [DNR]",
	MAX(CASE WHEN value = 'DNAR (Do Not Attempt Resuscitation) [DNR] / DNI' THEN 1 ELSE 0 END) AS "DNAR (Do Not Attempt Resuscitation) [DNR] / DNI",
	MAX(CASE WHEN value = 'DNI (do not intubate)' THEN 1 ELSE 0 END) AS "DNI (do not intubate)",
	MAX(CASE WHEN value = 'DNR (do not resuscitate)' THEN 1 ELSE 0 END) AS "DNR (do not resuscitate)",
	MAX(CASE WHEN value = 'DNR / DNI' THEN 1 ELSE 0 END) AS "DNR / DNI",
	MAX(CASE WHEN value = 'Early mobilization' THEN 1 ELSE 0 END) AS "Early mobilization",
	MAX(CASE WHEN value = 'Encourage family to participate in care' THEN 1 ELSE 0 END) AS "Encourage family to participate in care",
	MAX(CASE WHEN value = 'Encourage patient / family members to accept individual reponse to impending loss' THEN 1 ELSE 0 END) AS "Encourage patient / family members to accept individual reponse to impending loss",
	MAX(CASE WHEN value = 'Encourage patient / family to set and verbalize care goals' THEN 1 ELSE 0 END) AS "Encourage patient / family to set and verbalize care goals",
	MAX(CASE WHEN value = 'Enlist family support / family sitters' THEN 1 ELSE 0 END) AS "Enlist family support / family sitters",
	MAX(CASE WHEN value = 'Explanation' THEN 1 ELSE 0 END) AS "Explanation",
	MAX(CASE WHEN value = 'Family at bedside' THEN 1 ELSE 0 END) AS "Family at bedside",
	MAX(CASE WHEN value = 'Family Called' THEN 1 ELSE 0 END) AS "Family Called",
	MAX(CASE WHEN value = 'Family Conference' THEN 1 ELSE 0 END) AS "Family Conference",
	MAX(CASE WHEN value = 'Family Member' THEN 1 ELSE 0 END) AS "Family Member",
	MAX(CASE WHEN value = 'Family Talked to MD' THEN 1 ELSE 0 END) AS "Family Talked to MD",
	MAX(CASE WHEN value = 'Family Talked to RN' THEN 1 ELSE 0 END) AS "Family Talked to RN",
	MAX(CASE WHEN value = 'Family Visited' THEN 1 ELSE 0 END) AS "Family Visited",
	MAX(CASE WHEN value = 'Full code' THEN 1 ELSE 0 END) AS "Full code",
	MAX(CASE WHEN value = 'Full resistance' THEN 1 ELSE 0 END) AS "Full resistance",
	MAX(CASE WHEN value = 'Fully awake' THEN 1 ELSE 0 END) AS "Fully awake",
	MAX(CASE WHEN value = 'Listen attentively when patient attempts to communicate' THEN 1 ELSE 0 END) AS "Listen attentively when patient attempts to communicate",
	MAX(CASE WHEN value = 'Liver Failure' THEN 1 ELSE 0 END) AS "Liver Failure",
	MAX(CASE WHEN value = 'Manage environment for patient''s maximum comfort' THEN 1 ELSE 0 END) AS "Manage environment for patient''s maximum comfort",
	MAX(CASE WHEN value = 'Maintain GCS >= 8' THEN 1 ELSE 0 END) AS "Maintain GCS >= 8",
	MAX(CASE WHEN value = 'No Proxy' THEN 1 ELSE 0 END) AS "No Proxy",
	MAX(CASE WHEN value = 'No, not sedated' THEN 1 ELSE 0 END) AS "No, not sedated",
	MAX(CASE WHEN value = 'Palliative Care' THEN 1 ELSE 0 END) AS "Palliative Care",
	MAX(CASE WHEN value = 'Patient / family involved in treatment plan' THEN 1 ELSE 0 END) AS "Patient / family involved in treatment plan",
	MAX(CASE WHEN value = 'Patient / family will have adequate support once CMO decision has been made' THEN 1 ELSE 0 END) AS "Patient / family will have adequate support once CMO decision has been made",
	MAX(CASE WHEN value = 'Patient / family will have support throughout the dying process' THEN 1 ELSE 0 END) AS "Patient / family will have support throughout the dying process",
	MAX(CASE WHEN value = 'Patient / family will participate in planning and initiating current plan of care' THEN 1 ELSE 0 END) AS "Patient / family will participate in planning and initiating current plan of care",
	MAX(CASE WHEN value = 'Patient refused' THEN 1 ELSE 0 END) AS "Patient refused",
	MAX(CASE WHEN value = 'Patient Verbalized' THEN 1 ELSE 0 END) AS "Patient Verbalized",
	MAX(CASE WHEN value = 'Promote early mobility' THEN 1 ELSE 0 END) AS "Promote early mobility",
	MAX(CASE WHEN value = 'Rehab' THEN 1 ELSE 0 END) AS "Rehab",
	MAX(CASE WHEN value = 'Rehabilitation' THEN 1 ELSE 0 END) AS "Rehabilitation",
	MAX(CASE WHEN value = 'SBT' THEN 1 ELSE 0 END) AS "SBT",
	MAX(CASE WHEN value = 'Social Service Involved' THEN 1 ELSE 0 END) AS "Social Service Involved",
	MAX(CASE WHEN value = 'Social Services' THEN 1 ELSE 0 END) AS "Social Services",
	MAX(CASE WHEN value = 'Social Work' THEN 1 ELSE 0 END) AS "Social Work",
	MAX(CASE WHEN value = 'Spiritual' THEN 1 ELSE 0 END) AS "Spiritual",
	MAX(CASE WHEN value = 'Spouse' THEN 1 ELSE 0 END) AS "Spouse",
	MAX(CASE WHEN value = 'Thermoregulation' THEN 1 ELSE 0 END) AS "Thermoregulation",
	MAX(CASE WHEN value = 'TPN' THEN 1 ELSE 0 END) AS "TPN",
	MAX(CASE WHEN value = 'Tracheostomy' THEN 1 ELSE 0 END) AS "Tracheostomy",
	MAX(CASE WHEN value = 'Tracheostomy tube' THEN 1 ELSE 0 END) AS "Tracheostomy tube",
	MAX(CASE WHEN value = 'With family' THEN 1 ELSE 0 END) AS "With family",
	MAX(CASE WHEN value = 'With spouse' THEN 1 ELSE 0 END) AS "With spouse",
	MAX(CASE WHEN value = 'Withdraws' THEN 1 ELSE 0 END) AS "Withdraws"
FROM 
	mini_chart_date
GROUP BY
	stay_id,date
