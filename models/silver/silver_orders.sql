SELECT
    id,
    TO_YEAR(created_at) AS birth_year,
    user_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price as order_amount
FROM
{{ ref('bronze_orders') }}