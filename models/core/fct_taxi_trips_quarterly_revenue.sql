{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
)
    select 
    -- Revenue grouping 
    extract(year from pickup_datetime) as revenue_year,

    -- Revenue calculation 

    sum(total_amount) as revenue_quarterly_total_amount

    -- Additional calculations

    from trips_data
    group by revenue_year