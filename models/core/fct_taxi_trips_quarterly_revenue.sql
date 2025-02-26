{{ config(materialized='table') }}

with trips_data as (
    select * from `dezc-kestra`.`prod`.`fact_trips`
)
    select 
    -- Revenue grouping 
    {{ dbt.date_trunc("month", "pickup_datetime") }} as revenue_month, 
    {{ dbt.date_trunc("quarter", "pickup_datetime") }} as revenue_quarter, 
    {{ dbt.date_trunc("year", "pickup_datetime") }} as revenue_year,

    service_type, 

    -- Revenue calculation 
    sum(total_amount) as revenue_monthly_total_amount,


    from trips_data
    group by revenue_month