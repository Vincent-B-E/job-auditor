WITH missing AS (
    SELECT *
    FROM {{ ref('stg_postings') }}
    WHERE job_id IS NULL
)

SELECT
    DATE_TRUNC('MONTH', search_date) AS scrape_month,
    COUNT(*) AS postings,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM missing) * 100, 1) AS pct_of_missing
FROM missing
GROUP BY scrape_month
ORDER BY scrape_month