{{ config(materialized='table') }}

with source as (
    select * from {{ ref('bronze_orders') }}
),

renamed as (
    select
        ORDERID                  as order_id,
        CUSTOMERID               as customer_id,
        STATUS                   as status,
        TIMESTAMP(CREATEDAT)   as created_at,
        TIMESTAMP(UPDATEDAT)   as updated_at
    from source
)

select * from renamed
