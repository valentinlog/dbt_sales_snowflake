{{ config(materialized='table') }}

select
  product_id,
  product_name,
  category,
  price
from {{ ref('silver_products') }}
