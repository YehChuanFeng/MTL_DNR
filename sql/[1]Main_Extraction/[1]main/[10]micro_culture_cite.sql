DROP table IF EXISTS data_9.micro_culture_site;  
create table data_9.micro_culture_site AS




with all_spec_type as 
(
	SELECT
		DISTINCT(UPPER(spec_type_desc)) as cite
	FROM 
		mimiciv_hosp.microbiologyevents
)

SELECT
	cite,
	case 
		when 
			cite in ('PERITONEAL FLUID','BILE','RECTAL - R/O GC','STOOL (RECEIVED IN TRANSPORT SYSTEM)') then 'Abdomen'
		when 
			cite like '%BLOOD%' then 'Blood'
		when 
			cite like '%URINE%' or cite = 'ANORECTAL/VAGINAL' then 'Urinary tract'
		when 
			cite like '%SKIN%' or cite like '%WOUND%' or 
			cite in ('HAIR','FOREIGN BODY','BIOPSY')
			then 'Skin and soft tissue'
		when 
			cite in ('BRONCHIAL BRUSH','THROAT CULTURE','BRONCHIAL BRUSH - PROTECTED','ASPIRATE','BRONCHOALVEOLAR LAVAGE','BRONCHIAL WASHINGS','SPUTUM','RAPID RESPIRATORY VIRAL SCREEN & CULTURE'
					 ,'THROAT','RAPID RESPIRATORY VIRAL ANTIGEN TEST','INFLUENZA A/B BY DFA - BRONCH LAVAGE','TRACHEAL ASPIRATE')
			then 'Respiratory tract'
		else 
			'Others'
	end as "culture_site"
FROM 
	all_spec_type
ORDER BY 
	culture_site

