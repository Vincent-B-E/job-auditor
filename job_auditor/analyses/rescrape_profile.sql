WITH jobs AS (
    SELECT *
    FROM {{ ref('int_job_scrapes') }}
)

SELECT
    scrapes,
    COUNT(*) AS jobs,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM jobs) * 100, 1) AS jobs_pct    
FROM jobs
GROUP BY scrapes
ORDER BY scrapes