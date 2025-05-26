--篩value對應的item
with select_item as 
(
	SELECT 
		itemid
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
	GROUP BY
		itemid
)
--保留要找的itemid
, minichart as 
(
	SELECT 
		chart.itemid,
		chart.value
	FROM
		mimiciv_icu.chartevents as chart
	JOIN
		select_item
	ON
		chart.itemid = select_item.itemid
)
--計算row的數量
, minichart_group as 
(
	SELECT 
		itemid,value,count(*)
	FROM
		minichart
	GROUP BY
		itemid,value
)
--加入對應label
select 
	d_items.label,
	minichart_group.itemid,
	minichart_group.value,
	minichart_group.count
from minichart_group
left join mimiciv_icu.d_items as d_items
ON minichart_group.itemid = d_items.itemid
ORDER BY minichart_group.itemid