SELECT
    id,
    {{ date_trunc("year", "created_at") }} as order_year,
    user_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price as order_amount
FROM
{{ ref('bronze_orders') }}