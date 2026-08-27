{{ config(materialized='view') }}


select
    product_id,
    name as product_name,
    category,
    price
from {{ ref('dim_products') }}