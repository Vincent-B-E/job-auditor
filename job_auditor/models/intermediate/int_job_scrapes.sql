WITH postings AS (
    SELECT *
    FROM {{ ref('stg_postings') }}
)

SELECT
    job_id,
    COUNT(*) AS scrapes
FROM postings
GROUP BY job_id