{% macro null_check(table, column) -%}

SELECT
    '{{ column }}' AS column_name,
    '{{ column | replace('_', ' ') | title }}' AS column_label,
    COUNT(*) AS null_rows
FROM {{ ref(table) }}
WHERE {{ column }} IS NULL

{%- endmacro %}