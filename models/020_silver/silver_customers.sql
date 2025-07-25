{{ config(materialized='view') }}

select
  cast(customer_id as string) as customer_id,
  initcap(trim(customer_name)) as customer_name,
  email,
  city,
  country
from {{ ref('bronze_customers') }}
