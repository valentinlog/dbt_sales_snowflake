{{ config(materialized='view') }}

    select
        customer_id,
        name,
        phone,
        email,
        address,
        region,
        postal_zip,
        country

    from {{ ref('dim_customers') }}