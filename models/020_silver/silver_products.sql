{{ config(materialized='view') }}

select
  cast(product_id as string) as product_id,
  initcap(trim(product_name)) as product_name,
  cast(category as string) as category,
  cast(price as float) as price
from {{ ref('bronze_products') }}
