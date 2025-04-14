SELECT
    id,
    created_at,
    city,
    state,
    TO_YEAR(birth_date) AS birth_year,
    source as sales_channel
FROM
{{ ref('bronze_users') }}