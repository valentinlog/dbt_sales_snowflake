{{ config(materialized='view') }}


select
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    PRICE
from {{ ref('dim_products') }}