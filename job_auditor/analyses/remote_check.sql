WITH postings AS (
    SELECT
        job_id,
        is_remote
    FROM {{ ref('stg_postings') }}
    {% if var('role', none) %}
    WHERE search_term = '{{ var("role") }}'
    {% endif %}
),

remote AS (
    SELECT
        job_id
    FROM postings
    WHERE is_remote IS TRUE
)

SELECT
    COUNT(*) AS scrapes,
    COUNT(DISTINCT job_id) AS jobs,
    ROUND((SELECT COUNT(*) FROM remote) / COUNT(*) * 100, 1) AS pct_remote_by_scrapes,
    ROUND((SELECT COUNT(DISTINCT job_id) FROM remote) / COUNT(DISTINCT job_id) * 100, 1) AS pct_remote_by_jobs
FROM postings