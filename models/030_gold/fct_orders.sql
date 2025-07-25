{{ config(materialized='table') }}

select
  o.order_id,
  o.order_date,
  o.customer_id,
  c.customer_name,
  sum(i.quantity * i.unit_price) as total_amount,
  count(i.orderitem_id) as total_items
from {{ ref('silver_orders') }} o
left join {{ ref('silver_orderitems') }} i on o.order_id = i.order_id
left join {{ ref('silver_customers') }} c on o.customer_id = c.customer_id
group by o.order_id, o.order_date, o.customer_id, c.customer_name
