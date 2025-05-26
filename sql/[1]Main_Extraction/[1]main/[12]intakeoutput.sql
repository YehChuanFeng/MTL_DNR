
DROP table IF EXISTS data_9.intakeoutput_date; 
create table data_9.intakeoutput_date AS

--('ml','uL','L','nL')
with all_inputevent as   
(
	SELECT 
		stay_id,
		date_trunc('hour', starttime) as event_time,
		sum(case --amount
		   	    when amountuom = 'ml' THEN amount
				when amountuom = 'ul' THEN amount*0.001
				when amountuom = 'L'  THEN amount*1000
				when amountuom = 'nl' THEN amount*0.001*0.001
				else 0
		    end 
		   ) as inputevent_value
	FROM 
		mimiciv_icu.inputevents
	WHERE 
		amountuom in ('ml','uL','L','nL')
	group by stay_id,event_time	
)
--ingredientevents('ml')
,all_ingredient as   
(
	SELECT 
		stay_id,
		date_trunc('hour', starttime) as event_time,	
		sum(amount) as ingredient_value
	FROM 
		mimiciv_icu.ingredientevents
	WHERE 
		amountuom = 'ml' 
	group by stay_id,event_time	
)
--output中 'ml'
,all_outputevent as  
(
	SELECT
		stay_id,
		date_trunc('hour', charttime) as event_time,
		1 * sum(value) as output_value
	FROM
		mimiciv_icu.outputevents
	WHERE 
		valueuom = 'ml'
	group by stay_id,event_time	
)


,all_intake as  
(
	SELECT 
		COALESCE(all_ingredient.stay_id, all_inputevent.stay_id) as stay_id,
		COALESCE(all_ingredient.event_time, all_inputevent.event_time) as event_time,
		all_inputevent.inputevent_value,
		all_ingredient.ingredient_value
	FROM 
		all_inputevent
	FULL JOIN
		all_ingredient
	ON 
		all_ingredient.stay_id = all_inputevent.stay_id and all_ingredient.event_time = all_inputevent.event_time
)


,all_intakeoutput as  
(
	SELECT
		COALESCE(all_intake.stay_id, all_outputevent.stay_id) as stay_id,
		COALESCE(all_intake.event_time, all_outputevent.event_time) as event_time,
		COALESCE(all_intake.inputevent_value,0) as inputevent_value,
		COALESCE(all_intake.ingredient_value,0) as ingredient_value,
		COALESCE(all_outputevent.output_value,0) as output_value,
		(COALESCE(all_intake.inputevent_value,0) + COALESCE(all_intake.ingredient_value,0) - COALESCE(all_outputevent.output_value,0)) as total,
		(COALESCE(all_intake.inputevent_value,0)  - COALESCE(all_outputevent.output_value,0)) as total2
	FROM 
		all_intake
	FULL JOIN 
		all_outputevent
	ON 
		all_intake.stay_id = all_outputevent.stay_id and all_intake.event_time = all_outputevent.event_time
)


,cohort_intakeoutput as  
(
	SELECT
		all_intakeoutput.stay_id,
		all_intakeoutput.event_time,
		all_intakeoutput.inputevent_value,
		all_intakeoutput.ingredient_value,
		all_intakeoutput.output_value,
		all_intakeoutput.total,
		all_intakeoutput.total2
	FROM 
		all_intakeoutput
)


,cohort_intakeoutput_day as  
(
	SELECT
		stay_id,
		--all_intakeoutput.event_time,
		date_trunc('day', event_time) as date,	
		sum(inputevent_value) as inputevent_value,
		sum(ingredient_value) as ingredient_value,
		sum(output_value) as output_value,
		sum(total) as total,
		sum(total2) as total2
	FROM 
		cohort_intakeoutput
	GROUP BY 
		stay_id,date
)


select * from cohort_intakeoutput_day
order by stay_id,date