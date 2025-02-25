{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
)
    select 
    -- Revenue grouping 
    {{ dbt.date_trunc("year", "pickup_datetime") }} as revenue_year, 
    {{ dbt.date_trunc("month", "pickup_datetime") }} as revenue_month, 
    {{ dbt.date_trunc("quarter", "pickup_datetime") }} as revenue_quarter, 
    {{ dbt.date_trunc("year_quarter", "pickup_datetime") }} as revenue_year_quarter,

    service_type, 

    -- Revenue calculation 

    sum(total_amount) as revenue_quarterly_total_amount,

    -- Additional calculations

    from trips_data
    group by revenue_year_quarter