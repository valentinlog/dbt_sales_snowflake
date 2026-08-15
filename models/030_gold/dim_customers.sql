{{ config(
    materialized='table',
    unique_key='customer_id'
) }}

with source as (
    select
        customer_id,
        name,
        phone,
        email,
        address,
        region,
        postal_zip,
        country,
        cast(created_at as timestamp) as created_at,
        cast(updated_at as timestamp) as updated_at
    from {{ ref('silver_customers') }}
)

select *
from source
