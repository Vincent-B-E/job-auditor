{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='search_date'
    )
}}

WITH postings AS (
    SELECT *
    FROM {{ ref('stg_postings') }}
)

SELECT
    search_date,
    COUNT(*) AS postings
FROM postings
{% if is_incremental() %}
WHERE search_date > (SELECT MAX(search_date) FROM {{ this }})
{% endif %}
GROUP BY search_date