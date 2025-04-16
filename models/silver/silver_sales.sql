{{
      config(

                    materialized='incremental',
                    unique_key = ['sales_order_number', 'order_date', 'customer_name','item']
        
            )

}}
select
    sales_order_number,
    sales_order_linenumber,
    order_date,
    customer_name,
    email,
    item,
    quantity,
    unitprice,
    tax,
    case when order_date < '2019-08-01' then true else false end as is_flaged,
    current_timestamp() as created_ts
from {{ ref("bronze_sales") }}
