-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS data_9.ventilation; CREATE TABLE data_9.ventilation AS 
-- Classify oxygen devices and ventilator modes into six clinical categories.

-- Categories include..
--  Invasive oxygen delivery types: 
--      Tracheostomy (with or without positive pressure ventilation) 
--      InvasiveVent (positive pressure ventilation via endotracheal tube, could be oro/nasotracheal or tracheostomy)
--  Non invasive oxygen delivery types (divided similar to doi:10.1001/jama.2020.9524):
--      NonInvasiveVent (non-invasive positive pressure ventilation)
--      HFNC (high flow nasal oxygen / cannula)
--      SupplementalOxygen (all other non-rebreather, facemask, face tent, nasal prongs...)
--  No oxygen device:
--      None

-- When conflicting settings occur (rare), the priority is:
--  trach > mech vent > NIV > high flow > o2

-- Some useful cases for debugging:
--  stay_id = 30019660 has a tracheostomy placed in the ICU
--  stay_id = 30000117 has explicit documentation of extubation

-- first we collect all times which have relevant documentation

--同樣的(stay_id,charttime)只會保留一筆
WITH tm AS
(
  SELECT stay_id, charttime
  FROM data_9.ventilator_setting
  UNION DISTINCT
  SELECT stay_id, charttime
  FROM data_9.oxygen_delivery
)

--vs懶人包: 各時間點的類型
, vs AS
(
    SELECT tm.stay_id, tm.charttime
    -- source data columns, here for debug
    , o2_delivery_device_1
    , COALESCE(ventilator_mode, ventilator_mode_hamilton) AS vent_mode
    -- case statement determining the type of intervention
    -- done in order of priority: trach > mech vent > NIV > high flow > o2 (依優先順序完成：氣管 > 機械通氣 > NIV > 高流量 > O2)
    , CASE
    -- tracheostomy
    WHEN o2_delivery_device_1 IN
    (
        'Tracheostomy tube',
        'Trach mask ' -- 16435 observations
        -- 'T-piece', -- 1135 observations (T-piece could be either InvasiveVent or Tracheostomy)

    )
        THEN 'Tracheostomy'
	
    -- mechanical / invasive ventilation   ##  (1)o2_delivery_device_1 = 'Endotracheal tube'  (2)ventilator_mode  (3)ventilator_mode_hamilton
    WHEN o2_delivery_device_1 IN
    (
        'Endotracheal tube'
    )
    OR ventilator_mode IN
    (
        '(S) CMV',
        'APRV',
        'APRV/Biphasic+ApnPress',
        'APRV/Biphasic+ApnVol',
        'APV (cmv)',
        'Ambient',
        'Apnea Ventilation',
        'CMV',
        'CMV/ASSIST',
        'CMV/ASSIST/AutoFlow',
        'CMV/AutoFlow',
        'CPAP/PPS',
        'CPAP/PSV+Apn TCPL',
        'CPAP/PSV+ApnPres',
        'CPAP/PSV+ApnVol',
        'MMV',
        'MMV/AutoFlow',
        'MMV/PSV',
        'MMV/PSV/AutoFlow',
        'P-CMV',
        'PCV+',
        'PCV+/PSV',
        'PCV+Assist',
        'PRES/AC',
        'PRVC/AC',
        'PRVC/SIMV',
        'PSV/SBT',
        'SIMV',
        'SIMV/AutoFlow',
        'SIMV/PRES',
        'SIMV/PSV',
        'SIMV/PSV/AutoFlow',
        'SIMV/VOL',
        'SYNCHRON MASTER',
        'SYNCHRON SLAVE',
        'VOL/AC',
		'CPAP/PSV',  -- 20231018新增
		'CPAP',  -- 20231018新增
		'SPONT'  -- 20231018新增
		--'Standby'  -- 20231018新增  --20231028拿掉
    )
    OR ventilator_mode_hamilton IN
    (
        'APRV',
        'APV (cmv)',
        'Ambient',
        '(S) CMV',
        'P-CMV',
        'SIMV',
        'APV (simv)',
        'P-SIMV',
        'VS',
        'ASV',
		'CPAP/PSV',  -- 20231018新增
		'CPAP',  -- 20231018新增
		'SPONT'  -- 20231018新增
		--'Standby'  -- 20231018新增  --20231028拿掉
    )
        THEN 'InvasiveVent'
	---------------------------------------------
    -- NIV
    WHEN o2_delivery_device_1 IN
    (
        'Bipap mask ', -- 8997 observations
        'CPAP mask ' -- 5568 observations
    )
    OR ventilator_mode_hamilton IN
    (
        'DuoPaP',
        'NIV',
        'NIV-ST'
    )
        THEN 'NonInvasiveVent'
    -- high flow nasal cannula
    when o2_delivery_device_1 IN
    (
        'High flow nasal cannula' -- 925 observations
    )
        THEN 'HFNC'
    -- non rebreather
    WHEN o2_delivery_device_1 in
    ( 
        'Non-rebreather', -- 5182 observations
        'Face tent', -- 24601 observations
        'Aerosol-cool', -- 24560 observations
        'Venti mask ', -- 1947 observations
        'Medium conc mask ', -- 1888 observations
        'Ultrasonic neb', -- 9 observations
        'Vapomist', -- 3 observations
        'Oxymizer', -- 1301 observations
        'High flow neb', -- 10785 observations
        'Nasal cannula'
    )
        THEN 'SupplementalOxygen'
    WHEN o2_delivery_device_1 in 
    (
        'None'
    )
        THEN 'None'
    -- not categorized: other
    ELSE NULL END AS ventilation_status
  FROM tm
  LEFT JOIN data_9.ventilator_setting vs
      ON tm.stay_id = vs.stay_id
      AND tm.charttime = vs.charttime
  LEFT JOIN data_9.oxygen_delivery od
      ON tm.stay_id = od.stay_id
      AND tm.charttime = od.charttime
)
-- vd0懶人包: 抓前一次狀態、時間
, vd0 AS
(
    SELECT
      stay_id, charttime
      -- source data columns, here for debug
      -- , o2_delivery_device_1
      -- , vent_mode
      -- carry over the previous charttime which had the same state 延續具有相同狀態的前一個圖表時間
      , LAG(charttime, 1) OVER (PARTITION BY stay_id, ventilation_status ORDER BY charttime) AS charttime_lag
      -- bring back the next charttime, regardless of the state  返回下一個圖表時間，無論狀態如何
      -- this will be used as the end time for state transitions 這將用作狀態轉換的結束時間
      , LEAD(charttime, 1) OVER w AS charttime_lead
      , ventilation_status
      , LAG(ventilation_status, 1) OVER w AS ventilation_status_lag
    FROM vs
    WHERE ventilation_status IS NOT NULL
    WINDOW w AS (PARTITION BY stay_id ORDER BY charttime)
)
--vd1懶人包: (case.1)如果lag沒狀態，則為1  (case.2)離前一次lag超過14小時，則為1  (case.3)和lag狀態不同則為1
, vd1 as
(
    SELECT
        stay_id
        , charttime
        , charttime_lag
        , charttime_lead
        , ventilation_status

        -- source data columns, here for debug
        -- , o2_delivery_device_1
        -- , vent_mode

        -- calculate the time since the last event
        --, DATETIME_DIFF(charttime, charttime_lag, 'MINUTE')/60 as ventduration
	    ,(EXTRACT(EPOCH FROM (charttime - charttime_lag)) / 3600) as ventduration

        -- now we determine if the current ventilation status is "new", or continuing the previous
        , CASE
            -- if lag is null, this is the first event for the patient #如果lag為空，則這是患者的第一個事件
            WHEN ventilation_status_lag IS NULL THEN 1  
            -- a 14 hour gap always initiates a new event #14小時的間隔總是會引發新事件
            --WHEN DATETIME_DIFF(charttime, charttime_lag, 'HOUR') >= 14 THEN 1 
			WHEN EXTRACT(EPOCH FROM (charttime - charttime_lag)) / 3600 >= 14 THEN 1
            -- not a new event if identical to the last row #如果與最後一行相同，則不是新事件
            WHEN ventilation_status_lag != ventilation_status THEN 1
          ELSE 0
          END AS new_ventilation_event
    FROM vd0
)
-- vd2懶人包: 我們知道new_..為1是新狀態，所以這邊把該欄位加起來 = vent_seq  只要一樣的vent_seq就是同一次狀態裡面
, vd2 as
(
    SELECT vd1.stay_id, vd1.charttime
    , vd1.charttime_lead, vd1.ventilation_status
    , ventduration, new_ventilation_event
    -- create a cumulative sum of the instances of new ventilation
    -- this results in a monotonically increasing integer assigned 
    -- to each instance of ventilation
	-- 建立新 ventilation 實例的累積和，這會導致分配給每個 ventilation 實例的單調遞增整數
    , SUM(new_ventilation_event) OVER
    (
        PARTITION BY stay_id
        ORDER BY charttime
    ) AS vent_seq
    FROM vd1
)
-- create the durations for each ventilation instance
SELECT stay_id
  , MIN(charttime) AS starttime
  -- for the end time of the ventilation event, the time of the *next* setting
  -- i.e. if we go NIV -> O2, the end time of NIV is the first row with a documented O2 device
  -- ... unless it's been over 14 hours, in which case it's the last row with a documented NIV.
  , MAX(
        CASE
            WHEN charttime_lead IS NULL
            --OR DATETIME_DIFF(charttime_lead, charttime, 'HOUR') >= 14
	  		--OR EXTRACT(EPOCH FROM (charttime_lead - charttime)) / 3600 >= 14 
                THEN charttime
        ELSE charttime_lead
        END
   ) AS endtime
   -- all rows with the same vent_num will have the same ventilation_status
   -- for efficiency, we use an aggregate here,
   -- but we could equally well group by this column
  , MAX(ventilation_status) AS ventilation_status
FROM vd2
GROUP BY stay_id, vent_seq
--HAVING min(charttime) != max(charttime)
;