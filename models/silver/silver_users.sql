SELECT
    id,
    created_at,
    city,
    state,
    date(birth_date,'yyyy') AS birth_year,
    source as sales_channel
FROM
{{ ref('bronze_users') }}