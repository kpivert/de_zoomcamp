{{ config(materialized='table') }}

WITH trips_data AS (
    SELECT 
        fare_amount, 
        service_type, 
        EXTRACT(YEAR FROM pickup_datetime) AS year,
        EXTRACT(MONTH FROM pickup_datetime) AS month
    FROM `dezc-kestra.prod.fact_trips`
    WHERE fare_amount > 0
      AND trip_distance > 0
      AND LOWER(payment_type_description) IN ('cash', 'credit card')
)

SELECT 
    service_type,
    year,
    month,
    APPROX_QUANTILES(fare_amount, 100)[OFFSET(90)] AS p90,
    APPROX_QUANTILES(fare_amount, 100)[OFFSET(95)] AS p95,
    APPROX_QUANTILES(fare_amount, 100)[OFFSET(97)] AS p97
FROM trips_data
GROUP BY service_type, year, month
