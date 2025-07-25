{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}

with source as (
    select
        customer_id,
        name,
        phone,
        email,
        address,
        region,
        postal_zip,
        country,
        cast(created_at as timestamp) as created_at,
        cast(updated_at as timestamp) as updated_at,
        {{ dbt_utils.surrogate_key([
            'customer_id',
            'name',
            'phone',
            'email',
            'address',
            'region',
            'postal_zip',
            'country'
        ]) }} as record_hash
    from {{ ref('silver_customers') }}
)

{% if not is_incremental() %}
select
    customer_id,
    name,
    phone,
    email,
    address,
    region,
    postal_zip,
    country,
    created_at,
    updated_at,
    record_hash,
    current_timestamp() as valid_from,
    cast(null as timestamp) as valid_to,
    true as is_current
from source

{% else %}

{{ scd2_merge_simple(
    target_table=this,
    source_query=source,
    unique_key='customer_id',
    hash_key_column='record_hash',
    valid_from_column='valid_from',
    valid_to_column='valid_to',
    is_current_column='is_current'
) }}

{% endif %}
