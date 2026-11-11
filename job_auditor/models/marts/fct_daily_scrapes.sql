WITH postings AS (
    SELECT *
    FROM {{ ref('stg_postings') }}
)

SELECT
    search_date,
    COUNT(*) AS postings
FROM postings
GROUP BY search_date