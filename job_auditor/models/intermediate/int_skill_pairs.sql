WITH skills AS (
    SELECT *
    FROM {{ ref('stg_skills') }}
)

SELECT
    job_id,
    skill_id,
    COUNT(*) AS keyword_rows
FROM skills
GROUP BY job_id, skill_id