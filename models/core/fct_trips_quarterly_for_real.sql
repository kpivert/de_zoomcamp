{{ config(materialized='table') }}

WITH trips_data AS (
    SELECT * FROM `dezc-kestra`.`prod`.`fact_trips`
)

SELECT 
    -- Revenue grouping
    CONCAT(EXTRACT(YEAR FROM pickup_datetime), '-Q', EXTRACT(QUARTER FROM pickup_datetime)) AS quarter_year,

    service_type, 

    -- Revenue calculation 
    SUM(total_amount) AS revenue_monthly_total_amount

FROM trips_data
WHERE EXTRACT(YEAR FROM pickup_datetime) IN (2019, 2020)  -- Cleaner syntax
GROUP BY quarter_year, service_type  -- Corrected GROUP BY columns
