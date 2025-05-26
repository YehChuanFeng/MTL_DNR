DROP table IF EXISTS data_9.diagnoses_select; 
create table data_9.diagnoses_select AS


with diag_select_9 AS
(
	select  
		diag.subject_id,
		diag.hadm_id,
		cohort.stay_id,
		diag.icd_code,
		diag.icd_version,
		--diag.label,
    	case
			when icd_code like ('410%') then 'MI'
            
            when icd_code in ('39891','40201','40211','40291','40401','40403','40411','40413','40491','40493','4254','4255','4256','4257','4258','4259') then 'CHF'
            when icd_code like ('428%') then 'CHF'
            
            when icd_code in ('0930','4373','4431','4432','4433','4434','4435','4436','4437','4438','4439','5571','5579','V434') then 'PVD'
            when icd_code like ('440%') then 'PVD'
            when icd_code like ('441%') then 'PVD'
            when icd_code like ('471%') then 'PVD'
            
            when icd_code like ('3624%') then 'CVD'
            when icd_code like ('436%') then 'CVD'
            when icd_code like ('430%') then 'CVD'
            when icd_code like ('431%') then 'CVD'
            when icd_code like ('432%') then 'CVD'
            when icd_code like ('433%') then 'CVD'
            when icd_code like ('434%') then 'CVD'
            when icd_code like ('435%') then 'CVD'
            when icd_code like ('437%') then 'CVD'
            when icd_code like ('438%') then 'CVD'
            
            when icd_code in ('3312') then 'Dementia'
            when icd_code like ('290%') then 'Dementia'
            
            when icd_code in ('4168','4169','5064','5081','5088') then 'CPD'
            when icd_code like ('490%') then 'CPD'
            when icd_code like ('491%') then 'CPD'
            when icd_code like ('492%') then 'CPD'
            when icd_code like ('493%') then 'CPD'
            when icd_code like ('494%') then 'CPD'
            when icd_code like ('495%') then 'CPD'
            when icd_code like ('496%') then 'CPD'
            when icd_code like ('497%') then 'CPD'
            when icd_code like ('498%') then 'CPD'
            when icd_code like ('499%') then 'CPD'
            when icd_code like ('500%') then 'CPD'
            when icd_code like ('501%') then 'CPD'
            when icd_code like ('502%') then 'CPD'
            when icd_code like ('503%') then 'CPD'
            when icd_code like ('504%') then 'CPD'
            when icd_code like ('505%') then 'CPD'
            
            when icd_code in ('4465','7100','7101','7102','7103','7104','7140','7141','7142') then 'RD'
            
            when icd_code like ('531%') then 'PUD'
            when icd_code like ('532%') then 'PUD'
            when icd_code like ('533%') then 'PUD'
            when icd_code like ('534%') then 'PUD'
            
            when icd_code in ('07022','07023','07032','07033','07044','07054','0706','0709','5733','5734','5738','5739','V427') then 'MLD'
            when icd_code like ('570%') then 'MLD'
            when icd_code like ('571%') then 'MLD'
            
            when icd_code in ('25000') then 'DM_acute'
            when icd_code like ('2501%') then 'DM_acute'
            when icd_code like ('2502%') then 'DM_acute'
            when icd_code like ('2503%') then 'DM_acute'
            when icd_code like ('2508%') then 'DM_acute'
            when icd_code like ('2509%') then 'DM_acute'
            
            when icd_code like ('2504%') then 'DM_Chronic'
            when icd_code like ('2505%') then 'DM_Chronic'
            when icd_code like ('2506%') then 'DM_Chronic'
            when icd_code like ('2507%') then 'DM_Chronic'
            
            when icd_code in ('3341','34400','3441','3442','3444') then 'Hemiplegia'
            
            when icd_code in ('40301','40311','40391','40402','40403','40412','40413','40492','40493','583','5831','5832','5834','5836','5837') then 'Renal'
            when icd_code like ('588%') then 'Renal'
            when icd_code like ('V42%') then 'Renal'
            when icd_code like ('V451%') then 'Renal'
            
            when icd_code like ('140%') then 'Malignancy'
            when icd_code like ('141%') then 'Malignancy'
            when icd_code like ('142%') then 'Malignancy'
            when icd_code like ('143%') then 'Malignancy'
            when icd_code like ('144%') then 'Malignancy'
            when icd_code like ('145%') then 'Malignancy'
            when icd_code like ('146%') then 'Malignancy'
            when icd_code like ('147%') then 'Malignancy'
            when icd_code like ('148%') then 'Malignancy'
            when icd_code like ('149%') then 'Malignancy'
            when icd_code like ('150%') then 'Malignancy'
            when icd_code like ('151%') then 'Malignancy'
            when icd_code like ('152%') then 'Malignancy'
            when icd_code like ('153%') then 'Malignancy'
            when icd_code like ('154%') then 'Malignancy'
            when icd_code like ('155%') then 'Malignancy'
            when icd_code like ('157%') then 'Malignancy'
            when icd_code like ('158%') then 'Malignancy'
            when icd_code like ('159%') then 'Malignancy'
            when icd_code like ('160%') then 'Malignancy'
            when icd_code like ('161%') then 'Malignancy'
            when icd_code like ('162%') then 'Malignancy'
            when icd_code like ('163%') then 'Malignancy'
            when icd_code like ('164%') then 'Malignancy'
            when icd_code like ('165%') then 'Malignancy'
            when icd_code like ('170%') then 'Malignancy'
            when icd_code like ('171%') then 'Malignancy'
            when icd_code like ('172%') then 'Malignancy'
            when icd_code like ('173%') then 'Malignancy'
            when icd_code like ('174%') then 'Malignancy'
            when icd_code like ('175%') then 'Malignancy'
            when icd_code like ('176%') then 'Malignancy'
            when icd_code like ('177%') then 'Malignancy'
            when icd_code like ('179%') then 'Malignancy'
            when icd_code like ('180%') then 'Malignancy'
            when icd_code like ('181%') then 'Malignancy'
            when icd_code like ('182%') then 'Malignancy'
            when icd_code like ('183%') then 'Malignancy'
            when icd_code like ('184%') then 'Malignancy'
            when icd_code like ('185%') then 'Malignancy'
            when icd_code like ('186%') then 'Malignancy'
            when icd_code like ('187%') then 'Malignancy'
            when icd_code like ('188%') then 'Malignancy'
            when icd_code like ('189%') then 'Malignancy'
            when icd_code like ('190%') then 'Malignancy'
            when icd_code like ('191%') then 'Malignancy'
            when icd_code like ('192%') then 'Malignancy'
            when icd_code like ('193%') then 'Malignancy'
            when icd_code like ('194%') then 'Malignancy'
            when icd_code like ('200%') then 'Malignancy'
            when icd_code like ('201%') then 'Malignancy'
            when icd_code like ('202%') then 'Malignancy'
            when icd_code like ('203%') then 'Malignancy'
            when icd_code like ('204%') then 'Malignancy'
            when icd_code like ('205%') then 'Malignancy'
            when icd_code like ('206%') then 'Malignancy'
            when icd_code like ('207%') then 'Malignancy'
            when icd_code like ('208%') then 'Malignancy'
            
            
            when icd_code like ('456%') then 'LD'
            
            when icd_code like ('196%') then 'MST'
            when icd_code like ('197%') then 'MST'
            when icd_code like ('198%') then 'MST'
            when icd_code like ('199%') then 'MST'
            
            when icd_code like ('042%') then 'AIDS'
			end as label
		
        FROM 
			mimiciv_hosp.diagnoses_icd as diag, data_9.icu_detail as cohort
		where 
			cohort.hadm_id =  diag.hadm_id and diag.icd_version = 9
),
----------------------------------------------------------------------------------------------------------------------------
diag_select_10 AS
(
	select  
		diag.subject_id,
		diag.hadm_id,
		cohort.stay_id,
		diag.icd_code,
		diag.icd_version,
    	case
			when icd_code in ('I0981','I50') then 'MI'
            when icd_code like ('I11%') then 'MI'
      	    when icd_code like ('I13%') then 'MI'

	
			when icd_code like ('I97%') then 'CHF' 
			when icd_code like ('O29%') then 'CHF'
			when icd_code in ('P290') then 'CHF'
	
			when icd_code in ('I73','I738','I7389','I739','Q27','Q278','Z95820','Z9862') then 'PVD' 
	
			when icd_code in ('A5054,A5209,Q8741,Q87418') then 'CVD' 
			when icd_code like ('Y71%') then 'CVD'
	
			when icd_code in ('J80','P22','P220','P228','P229','P2811') then 'RD' 
            
			when icd_code like ('K27%') then 'PUD' 
			when icd_code in ('P7882','Z8711') then 'PUD' 
		
			when icd_code like ('E08%') then 'Diabetes Mellitus' 
			when icd_code like ('E09%') then 'Diabetes Mellitus'
			when icd_code like ('E10%') then 'Diabetes Mellitus' 
			when icd_code like ('E11%') then 'Diabetes Mellitus' 
			when icd_code like ('E12%') then 'Diabetes Mellitus'
	
	
			when icd_code like ('G81%') then 'Hemiplegia'  
			when icd_code like ('I69%') then 'Hemiplegia'
	
			when icd_code in ('A187','A985') then 'Renal'
			when icd_code like ('C64%') then 'Renal'
			when icd_code like ('C65%') then 'Renal'
			when icd_code like ('C74%') then 'Renal'
			when icd_code like ('C79%') then 'Renal'
			when icd_code like ('D301%') then 'Renal'
			when icd_code like ('D350%') then 'Renal'
			when icd_code like ('D411%') then 'Renal'
			when icd_code like ('D441%') then 'Renal'
	
			when icd_code like ('E27%') then 'Renal'
			when icd_code like ('D441%') then 'Renal'
			when icd_code like ('E27%') then 'Renal'
			when icd_code in ('I120','I1311','I132','I151','I701','I722','I7773','I823','K767','K9183','M3130','M3131','N132','N186','N23','N269') then 'Renal'
			when icd_code in ('O0332','O0382','O0482','O0732','O084','O','Q627','Q891','R392','P544','P960','Z8553','Z9115','Z992') then 'Renal'
			when icd_code like ('M103%') then 'Renal'
			when icd_code like ('M1A3%') then 'Renal'
			when icd_code like ('N15%') then 'Renal'
			when icd_code like ('N15%') then 'Renal'
			when icd_code like ('N15%') then 'Renal'
			when icd_code like ('N15%') then 'Renal'
			when icd_code like ('N15%') then 'Renal'
			when icd_code like ('N15%') then 'Renal'
			when icd_code like ('N25%') then 'Renal'
			when icd_code like ('O03%') then 'Renal'
			when icd_code like ('O268%') then 'Renal'
			when icd_code like ('Q27%') then 'Renal'
			when icd_code like ('Q60%') then 'Renal'
			when icd_code like ('Q61%') then 'Renal'
			when icd_code like ('Q62%') then 'Renal'
			when icd_code like ('S354%') then 'Renal'
			when icd_code like ('S3781%') then 'Renal'
			when icd_code like ('T81711%') then 'Renal'
			when icd_code like ('Z49%') then 'Renal'
	
			
			when icd_code in ('C01','C07','C12','C19','C20','C23','C37','R530','Z08','Z09','Z860','Z8603') then 'Malignancy'
			when icd_code like ('C00%') then 'Malignancy'
			when icd_code like ('C02%') then 'Malignancy'
			when icd_code like ('C03%') then 'Malignancy'
			when icd_code like ('C04%') then 'Malignancy'
			when icd_code like ('C05%') then 'Malignancy'
			when icd_code like ('C06%') then 'Malignancy'
			when icd_code like ('C08%') then 'Malignancy'
			when icd_code like ('C09%') then 'Malignancy'
			when icd_code like ('C10%') then 'Malignancy'
			when icd_code like ('C11%') then 'Malignancy'
			when icd_code like ('C13%') then 'Malignancy'
			when icd_code like ('C14%') then 'Malignancy'
			when icd_code like ('C15%') then 'Malignancy'
			when icd_code like ('C16%') then 'Malignancy'
			when icd_code like ('C17%') then 'Malignancy'
			when icd_code like ('C18%') then 'Malignancy'
			when icd_code like ('C21%') then 'Malignancy'
			when icd_code like ('C22%') then 'Malignancy'
			when icd_code like ('C24%') then 'Malignancy'
			when icd_code like ('C25%') then 'Malignancy'
			when icd_code like ('C26%') then 'Malignancy'
			when icd_code like ('C30%') then 'Malignancy'
			when icd_code like ('C31%') then 'Malignancy'
			when icd_code like ('C32%') then 'Malignancy'
			when icd_code like ('C33%') then 'Malignancy'
			when icd_code like ('C34%') then 'Malignancy'
			when icd_code like ('C38%') then 'Malignancy'
			when icd_code like ('C39%') then 'Malignancy'
			when icd_code like ('C40%') then 'Malignancy'
			when icd_code like ('C41%') then 'Malignancy'
			when icd_code like ('C43%') then 'Malignancy'
			when icd_code like ('C44%') then 'Malignancy'
			when icd_code like ('C47%') then 'Malignancy'
			when icd_code like ('C48%') then 'Malignancy'
			when icd_code like ('C49%') then 'Malignancy'
			when icd_code like ('C50%') then 'Malignancy'
			when icd_code like ('C51%') then 'Malignancy'
			when icd_code like ('C52%') then 'Malignancy'
			when icd_code like ('C53%') then 'Malignancy'
			when icd_code like ('C54%') then 'Malignancy'
			when icd_code like ('C55%') then 'Malignancy'
			when icd_code like ('C56%') then 'Malignancy'
			when icd_code like ('C57%') then 'Malignancy'
			when icd_code like ('C58%') then 'Malignancy'
			when icd_code like ('C6%') then 'Malignancy'  
			when icd_code like ('C7%') then 'Malignancy'
			when icd_code like ('C8%') then 'Malignancy'
			when icd_code like ('C91%') then 'Malignancy'
			when icd_code like ('C92%') then 'Malignancy'
			when icd_code like ('C93%') then 'Malignancy'
			when icd_code like ('C94%') then 'Malignancy'
			when icd_code like ('C95%') then 'Malignancy'
			when icd_code like ('C96%') then 'Malignancy'
			when icd_code like ('C97%') then 'Malignancy'
			when icd_code like ('O9A%') then 'Malignancy'
			when icd_code like ('Z12%') then 'Malignancy'
			when icd_code like ('Z15%') then 'Malignancy'
			when icd_code like ('Z80%') then 'Malignancy'
			when icd_code like ('Z85%') then 'Malignancy'

			when icd_code like ('B20%') then 'AIDS' 
			
			when icd_code like ('O33%') then 'CPD'  
	
			when icd_code like ('E71%') then 'LD' 
	
			when icd_code in ('E7525') then 'MLD'  
		
			when icd_code in ('F1027','F1097','F1327','F1397','F1817','F1827','F1897','F1917') then 'Dementia'  
			end as label
	
        from 
			mimiciv_hosp.diagnoses_icd as diag, data_9.icu_detail as cohort
		where 
			cohort.subject_id = diag.subject_id and diag.icd_version = 10
)

,icd_name as 
(
	select *
	from mimiciv_hosp.d_icd_diagnoses
)


, target as 
(
	SELECT * --subject_id,hadm_id,stay_id,label
	FROM diag_select_9
	where label is not null

	UNION

	SELECT * --subject_id,hadm_id,stay_id,label 
	FROM diag_select_10
	where label is not null
)
--select * from icd_name

select
	subject_id,
	hadm_id,
	stay_id,
	label
from target
left join icd_name
on target.icd_code = icd_name.icd_code and target.icd_version = icd_name.icd_version and label is not null