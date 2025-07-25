{{ config(materialized='table') }}

select
  i.orderitem_id,
  i.order_id,
  i.product_id,
  p.product_name,
  i.quantity,
  i.unit_price,
  i.quantity * i.unit_price as line_total
from {{ ref('silver_orderitems') }} i
left join {{ ref('silver_products') }} p on i.product_id = p.product_id
