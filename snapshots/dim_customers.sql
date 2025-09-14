{% snapshot dim_customers %}

{{
    config(
        unique_key='customer_id',
        target_schema='gold',
        strategy='check',
        check_cols=[
            'name', 'phone', 'email', 'address', 'region', 'postal_zip', 'country'
        ]
    )
}}

select
    customer_id,
    name,
    phone,
    email,
    address,
    region,
    postal_zip,
    country

from {{ ref('silver_customers') }}

{% endsnapshot %}
