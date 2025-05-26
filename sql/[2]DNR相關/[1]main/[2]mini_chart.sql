DROP table IF EXISTS pj_dnr.mini_chart;  
create table pj_dnr.mini_chart AS
/*
DNR主要相關特徵表格 ==> tabel名稱再自己改成合適的
*/

with mini_chart as 
(
	SELECT 
		*
	FROM 
		mimiciv_icu.chartevents
	WHERE value IN (
		'Anxiety',
		'Assess for anxiety, depression, or delirium which may contribute to pain and interfere with pain management',
		'Asystole',
		'Blood Transfusion',
		'Consult to pastoral care, social services, palliative care, psychiatric services, case management as indicated',
		'DNAR (Do Not Attempt Resuscitation) [DNR]',
		'DNAR (Do Not Attempt Resuscitation) [DNR] / DNI',
		'DNI (do not intubate)',
		'DNR (do not resuscitate)',
		'DNR / DNI',
		'Early mobilization',
		'Encourage family to participate in care',
		'Encourage patient / family members to accept individual reponse to impending loss',
		'Encourage patient / family to set and verbalize care goals',
		'Enlist family support / family sitters',
		'Explanation',
		'Family at bedside',
		'Family Called',
		'Family Conference',
		'Family Member',
		'Family Talked to MD',
		'Family Talked to RN',
		'Family Visited',
		'Full code',
		'Full resistance',
		'Fully awake',
		'Listen attentively when patient attempts to communicate',
		'Liver Failure',
		'Manage environment for patient''s maximum comfort',
		'Maintain GCS >= 8',
		'No Proxy',
		'No, not sedated',
		'Palliative Care',
		'Patient / family involved in treatment plan',
		'Patient / family will have adequate support once CMO decision has been made',
		'Patient / family will have support throughout the dying process',
		'Patient / family will participate in planning and initiating current plan of care',
		'Patient refused',
		'Patient Verbalized',
		'Promote early mobility',
		'Rehab',
		'Rehabilitation',
		'SBT',
		'Social Service Involved',
		'Social Services',
		'Social Work',
		'Spiritual',
		'Spouse',
		'Thermoregulation',
		'TPN',
		'Tracheostomy',
		'Tracheostomy tube',
		'With family',
		'With spouse',
		'Withdraws'
	) and itemid != '220001'
)

select * from mini_chart