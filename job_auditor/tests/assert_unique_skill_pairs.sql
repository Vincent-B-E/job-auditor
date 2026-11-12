WITH pairs AS (
    SELECT
        job_id,
        skill_id,
        COUNT(*) AS copies
    FROM {{ ref('int_skill_pairs') }}
    GROUP BY job_id, skill_id
)

SELECT *
FROM pairs
WHERE copies >= 2