DROP TABLE IF EXISTS data_9.icu_detail; 
CREATE TABLE data_9.icu_detail AS

WITH icu_detail AS
(
	SELECT ie.subject_id, ie.hadm_id, ie.stay_id

	-- patient level factors
	, pat.gender, pat.dod

	-- hospital level factors
	, adm.admittime, adm.dischtime
	--, DATETIME_DIFF(adm.dischtime, adm.admittime, DAY) as los_hospital
	, DATE_PART('day',adm.dischtime - adm.admittime) AS los_hospital

	--DATETIME_DIFF(adm.admittime, DATETIME(pat.anchor_year, 1, 1, 0, 0, 0), YEAR) + pat.anchor_age as admission_age
	, pat.anchor_age as age
	, adm.race
	, adm.hospital_expire_flag
	, DENSE_RANK() OVER (PARTITION BY adm.subject_id ORDER BY adm.admittime) AS hospstay_seq
	, CASE
		WHEN DENSE_RANK() OVER (PARTITION BY adm.subject_id ORDER BY adm.admittime) = 1 THEN True
		ELSE False END AS first_hosp_stay

	-- icu level factors
	, ie.intime as icu_intime, ie.outtime as icu_outtime
	--, ROUND(CAST(DATETIME_DIFF(ie.outtime, ie.intime, HOUR)/24.0 AS NUMERIC), 2) as los_icu
	--, ROUND(CAST(DATE_PART('HOUR',ie.outtime - ie.intime)/24.0 AS NUMERIC), 2) as los_icu
	, DATE_PART('day', ie.outtime::date) - DATE_PART('day', ie.intime::date)+1  AS los_icu  --改成單純看天數(無小數所以+1)
	, DENSE_RANK() OVER (PARTITION BY ie.hadm_id ORDER BY ie.intime) AS icustay_seq

	-- first ICU stay *for the current hospitalization*
	, CASE
		WHEN DENSE_RANK() OVER (PARTITION BY ie.hadm_id ORDER BY ie.intime) = 1 THEN True
		ELSE False END AS first_icu_stay

	FROM mimiciv_icu.icustays ie
	INNER JOIN mimiciv_hosp.admissions adm
		ON ie.hadm_id = adm.hadm_id
	INNER JOIN mimiciv_hosp.patients pat
		ON ie.subject_id = pat.subject_id
)
,DNR as 
(
	select 
		subject_id,
		MAX(case when value like '%DNR%' then 1 else 0 end) as DNR
	from mimiciv_icu.chartevents
	group by subject_id
)
,aps AS
(
	select 
		stay_id,
		apsiii
	from mimiciv_derived.apsiii
)
, target_1 as 
(
	select  
		icu_detail.subject_id,
		hadm_id,
		stay_id,
		gender,
		dod,
		admittime,
		dischtime,
		los_hospital,
		age,
		race,
		DNR,
		hospital_expire_flag,
		hospstay_seq,
		first_hosp_stay,
		icu_intime,
		icu_outtime,
		los_icu,
		--days_diff,
		icustay_seq,
		first_icu_stay
	from icu_detail
	left join DNR
	on icu_detail.subject_id = DNR.subject_id
	order by icu_detail.subject_id,icustay_seq,stay_id
)
, target_2 as 
(
	select 
		target_1.subject_id,
		hadm_id,
		target_1.stay_id,
		gender,
		dod,
		admittime,
		dischtime,
		los_hospital,
		age,
		race,
		DNR,
		apsiii,
		hospital_expire_flag,
		hospstay_seq,
		first_hosp_stay,
		icu_intime,
		icu_outtime,
		los_icu,
		icustay_seq,
		first_icu_stay
	from target_1
	left join aps
	on target_1.stay_id = aps.stay_id
	order by target_1.subject_id,icustay_seq,target_1.stay_id
)
--------------------------------------

select * from target_2
order by subject_id,stay_id
