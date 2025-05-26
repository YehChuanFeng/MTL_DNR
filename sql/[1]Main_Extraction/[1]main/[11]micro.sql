DROP table IF EXISTS data_9.micro_new; 
create table data_9.micro_new AS

--篩欄位跟保留要的患者
with a as 
(
	SELECT
		m.subject_id,
		m.chartdate,
		m.charttime,
		m.spec_type_desc,
		m.org_itemid,
		m.org_name
	from mimiciv_hosp.microbiologyevents as m, data_9.icu_detail as c
	where org_name is not NULL and m.subject_id = c.subject_id
	--limit 50
)


--加入醫師給的菌種辨識 => 字串比對
, b as 
(
	select * from a 
	left join defind_gram_stain as b
	on UPPER(a.org_name) = UPPER(b.bacteria)
)

, b2 as 
(
	select * from b
	LEFT JOIN
	data_9.micro_culture_site
	on UPPER(b.spec_type_desc) = data_9.micro_culture_site.cite
								
)

--新增5種細菌類別
, c as 
(
	SELECT
		subject_id,
		chartdate,
		charttime,
		spec_type_desc,
		culture_site,
		org_itemid,
		org_name,
		--bacteria,
		--gram_stain,
	
		case
            when org_itemid in (80062,80063,80066,80114,80148,80215,80239,80297) then 1
			else 0
        end as "Aspergillus",
		case
            when org_itemid in (80059,80060,80099,80100,80101,80106,80137,80228,80254,80269,80267,80285,80288,80059) then 1
			else 0
        end as "Candida",
		case
            when gram_stain = 'GPB' then 1
			else 0
        end as "GPB",
		case
            when gram_stain = 'GNB' then 1
			else 0
        end as "GNB",
		case
            when gram_stain = 'Fungi' then 1
			else 0
        end as "Fungi",
	
		case when gram_stain is not null and culture_site = 'Abdomen' then 1 else 0 end as "Abdomen",
		case when gram_stain is not null and culture_site = 'Blood' then 1 else 0 end as "Blood",
		case when gram_stain is not null and culture_site = 'Respiratory tract' then 1 else 0 end as "Respiratory tract",
		case when gram_stain is not null and culture_site = 'Skin and soft tissue' then 1 else 0 end as "Skin and soft tissue",
		case when gram_stain is not null and culture_site = 'Urinary tract' then 1 else 0 end as "Urinary tract",
		case when gram_stain is not null and culture_site = 'Others' then 1 else 0 end as "Others"
			
	FROM b2	
)


--整合到以天為單位
, d as 
(
	SELECT
		subject_id,
		chartdate,
		MAX("Aspergillus") as "Aspergillus",
		MAX("Candida") as "Candida",
		--MAX("GPB") as "GPB",
		--MAX("GNB") as "GNB",
		--MAX("Fungi") as "Fungi",
		--Abdomen、Blood、Respiratory tract、Skin and soft tissue、Urinary tract
		MAX("Abdomen") as "Abdomen",
		MAX("Blood") as "Blood",
		MAX("Respiratory tract") as "Respiratory tract",
		MAX("Skin and soft tissue") as "Skin and soft tissue",
		MAX("Urinary tract") as "Urinary tract",
		MAX("Others") as "Others"
	FROM 
		c
	WHERE
		"Aspergillus" is not null and 
		"Candida" is not null and 
		"GPB" is not null and 
		"GNB" is not null and 
		"Fungi" is not null
	GROUP BY subject_id,chartdate
)

select *
from d
order by subject_id,chartdate


/*
Abdomen
Blood
Respiratory tract
Skin and soft tissue
Urinary tract
Others
*/
