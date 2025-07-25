{{ config(materialized='view') }}

select
  cast(orderitem_id as string) as orderitem_id,
  cast(order_id as string) as order_id,
  cast(product_id as string) as product_id,
  cast(quantity as int) as quantity,
  cast(unit_price as float) as unit_price
from {{ ref('bronze_orderitems') }}
