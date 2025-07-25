{{ config(
    materialized='table',
    incremental_strategy='merge',  -- Optional; ignored by scd2_merge_simple
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
        {{ dbt_utils.generate_surrogate_key([
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

{{ dbt_utils.scd2_merge_simple(
    target_table=this,
    source_query='source',
    unique_key='customer_id',
    hash_key_column='record_hash',
    valid_from_column='valid_from',
    valid_to_column='valid_to',
    is_current_column='is_current'
) }}

