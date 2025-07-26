{{ config(
    materialized='incremental',
    unique_key='product_id'
) }}

select
    product_id,
    name as product_name,
    category,
    price,
    created_at,
    updated_at
from {{ ref('silver_products') }}
