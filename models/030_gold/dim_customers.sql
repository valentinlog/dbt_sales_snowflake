{{ config(materialized='table') }}

select
  customer_id,
  customer_name,
  email,
  city,
  country
from {{ ref('silver_customers') }}
