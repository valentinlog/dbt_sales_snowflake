{% macro scd2_merge_simple(target_table, source_query, unique_key, hash_key_column='record_hash', valid_from_column='valid_from', valid_to_column='valid_to', is_current_column='is_current') %}

merge into {{ target_table }} target
using (
  {{ source_query }}
) source
on target.{{ unique_key }} = source.{{ unique_key }} and target.{{ is_current_column }} = true

when matched and target.{{ hash_key_column }} != source.{{ hash_key_column }} then
  update set
    {{ is_current_column }} = false,
    {{ valid_to_column }} = current_timestamp()

when not matched then
  insert (
    {{ unique_key }},
    {{ hash_key_column }},
    {{ valid_from_column }},
    {{ valid_to_column }},
    {{ is_current_column }}
  )
  values (
    source.{{ unique_key }},
    source.{{ hash_key_column }},
    current_timestamp(),
    null,
    true
  );

{% endmacro %}
