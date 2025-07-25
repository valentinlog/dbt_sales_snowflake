{{ config(materialized='view') }}

select
  cast(order_id as string) as order_id,
  cast(customer_id as string) as customer_id,
  cast(order_date as date) as order_date,
  cast(status as string) as status
from {{ ref('bronze_orders') }}
