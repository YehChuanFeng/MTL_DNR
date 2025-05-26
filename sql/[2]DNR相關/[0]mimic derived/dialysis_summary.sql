DROP TABLE IF EXISTS mimiciv_derived.dialysis_summary;

CREATE TABLE mimiciv_derived.dialysis_summary AS

SELECT 
    st.subject_id,
    st.stay_id,
    DATE(rt.charttime) AS date,
    MAX(rt.dialysis_active) AS dialysis
FROM 
    mimiciv_icu.icustays st
INNER JOIN 
    mimiciv_derived.rrt rt ON st.stay_id = rt.stay_id
GROUP BY 
    st.subject_id, st.stay_id, DATE(rt.charttime)
ORDER BY 
    st.subject_id, st.stay_id, DATE(rt.charttime);
