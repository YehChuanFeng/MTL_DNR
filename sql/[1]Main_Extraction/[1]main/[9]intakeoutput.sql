/*
Fluid_intake、Nutrition_Enteral、Urine
*/

DROP table IF EXISTS data_9.intakeoutput_new; 
create table data_9.intakeoutput_new AS

with Fluid_intake_item as 
(
	select 
		itemid 
	from 
		mimiciv_icu.d_items
	where 
		linksto = 'inputevents' and category = 'Fluids/Intake'
)
, Nutrition_Enteral_item as    
(
	select 
		itemid 
	from 
		mimiciv_icu.d_items
	where 
		linksto = 'inputevents' and category like '%Nutrition%' 
)

,Fluid_intake as   
(
	select 
		stay_id,
		date_trunc('day', starttime) as date,	
		sum(case --amount
		   	    when amountuom = 'ml' THEN amount
				when amountuom = 'ul' THEN amount*0.001
				when amountuom = 'L'  THEN amount*1000
				when amountuom = 'nl' THEN amount*0.001*0.001
				else 0
		    end 
		   ) as "Fluid_intake_value"
	from 
		mimiciv_icu.inputevents as input, Fluid_intake_item as item
	where 
		amountuom in ('ml','uL','L','nL') and input.itemid = item.itemid
	group by 
		stay_id,date
)

,Nutrition_Enteral as   
(
	select 
		stay_id,
		date_trunc('day', starttime) as date,	
		sum(case --amount
		   	    when amountuom = 'ml' THEN amount
				when amountuom = 'ul' THEN amount*0.001
				when amountuom = 'L'  THEN amount*1000
				when amountuom = 'nl' THEN amount*0.001*0.001
				else 0
		    end 
		   ) as "Nutrition_Enteral_value"
	from 
		mimiciv_icu.inputevents as input, Nutrition_Enteral_item as item
	where 
		amountuom in ('ml','uL','L','nL') and input.itemid = item.itemid
	group by 
		stay_id,date
)
,Urine as   
(
	select 
		stay_id,
		date_trunc('day', charttime) as date,	
		sum(value) as "Urine_value"
	from 
		mimiciv_icu.outputevents as output
	where 
		itemid in ('224458','226557','226558','226559','226560','226561','226563','226564','226565','226566','226567','226569')
	group by 
		stay_id,date
)
, Merge1 as
(
	SELECT 
		A.stay_id, 
		A.date, 
		A."Fluid_intake_value",
		B."Nutrition_Enteral_value"
	FROM 
		Fluid_intake as A
	FULL JOIN 
		Nutrition_Enteral as B 
	ON 
		A.stay_id = B.stay_id AND A.date = B.date
)
, Merge2 as
(
	SELECT 
		A.stay_id, 
		A.date, 
		A."Fluid_intake_value",
		A."Nutrition_Enteral_value",
		B."Urine_value"
	FROM 
		Merge1  as A
	FULL JOIN 
		Urine as B 
	ON 
		A.stay_id = B.stay_id AND A.date = B.date
)
, Merge3 as
(
	SELECT 
		A.stay_id, 
		A.date, 
		A."Fluid_intake_value",
		A."Nutrition_Enteral_value",
		A."Urine_value"
	FROM 
		Merge2 as A
)

select * from Merge3
order by stay_id,date