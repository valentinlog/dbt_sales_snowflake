SELECT
    id,
    created_at,
    city,
    state,
    year(cast(birth_date as date)) as birth_year,
    source as sales_channel
FROM
{{ ref('bronze_users') }}