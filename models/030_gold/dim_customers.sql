{{ config(materialized='table') }}

with source as (
    select * from {{ ref('silver_customers') }}
),

scd2 as (
    select
        customer_id,
        name,
        phone,
        email,
        address,
        region,
        postal_zip,
        country,
        created_at,
        updated_at,
        {{ dbt_utils.generate_surrogate_key(['customer_id', 'name', 'phone', 'email', 'address', 'region', 'postal_zip', 'country']) }} as scd_hash,
        row_number() over (
            partition by customer_id
            order by updated_at desc nulls last
        ) = 1 as is_current
    from source
)

select * from scd2
