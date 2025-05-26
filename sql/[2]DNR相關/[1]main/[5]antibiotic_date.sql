DROP table IF EXISTS pj_dnr.antibiotic_date;
create table pj_dnr.antibiotic_date AS

/*antibiotic，以日為單位*/
SELECT 
	stay_id,
	1 as antibiotic,
	Date(starttime) as starttime,
	Date(stoptime) as endtime
FROM 
	pj_dnr.abx
WHERE
	stay_id is not null
Order By
	stay_id,starttime