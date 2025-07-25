{% macro scd2_merge_simple(
    target_table=None,
    source_table=None,
    unique_key=None,
    hash_key_column=None,
    valid_from_column=None,
    valid_to_column=None,
    is_current_column=None
) %}
    merge into {{ target_table }} as target
    using {{ source_table }} as source
    on target.{{ unique_key }} = source.{{ unique_key }}
       and target.{{ is_current_column }} = true
       and target.{{ hash_key_column }} != source.{{ hash_key_column }}

    when matched then update set
        {{ valid_to_column }} = current_timestamp(),
        {{ is_current_column }} = false

    when not matched by target then insert (
        {{ unique_key }}, name, phone, email, address, region, postal_zip, country,
        created_at, updated_at, {{ hash_key_column }}, {{ valid_from_column }}, {{ valid_to_column }}, {{ is_current_column }}
    )
    values (
        source.{{ unique_key }}, source.name, source.phone, source.email, source.address,
        source.region, source.postal_zip, source.country,
        source.created_at, source.updated_at, source.{{ hash_key_column }},
        current_timestamp(), null, true
    );
{% endmacro %}
