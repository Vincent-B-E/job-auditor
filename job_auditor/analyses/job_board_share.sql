WITH postings AS (
    SELECT
        job_id,
        company_name
    FROM {{ ref('stg_postings') }}
    {% if var('role', none) %}
    WHERE search_term = '{{ var("role") }}'
    {% endif %}
),

job_boards AS (
    SELECT *
    FROM {{ ref('job_boards') }}
)

SELECT
    company_name,
    board_type,
    COUNT(DISTINCT job_id) AS jobs,
    ROUND(
        COUNT(DISTINCT job_id) 
        / (SELECT COUNT(DISTINCT job_id) FROM postings)
        * 100, 1) AS jobs_pct
FROM postings
INNER JOIN job_boards USING (company_name)
GROUP BY company_name, board_type
ORDER BY jobs DESC