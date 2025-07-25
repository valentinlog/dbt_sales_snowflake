{{ config(materialized='table') }}

with source as (
    select * from {{ ref('bronze_products') }}
),

renamed as (
    select
        PRODUCTID       as product_id,
        NAME            as name,
        CATEGORY        as category,
        PRICE           as price,
        TIMESTAMP(CREATEDAT)  as created_at,
        TIMESTAMP(UPDATEDAT)  as updated_at
    from source
)

select * from renamed
