WITH source AS (
    SELECT *
    FROM {{ source('jobs', 'raw_job_postings') }}
    WHERE error IS NOT TRUE
    AND job_id IS NOT NULL
),

cleaned AS (
    SELECT
        job_id,
        job_title,
        company_name,
        job_location,
        REGEXP_REPLACE(job_via, '^via ', '') AS source_platform,
        job_schedule_type,
        ARRAY_CONTAINS(
            FROM_JSON(job_extensions_raw, 'array<string>'),
            'Work from home'
        ) AS is_remote,
        job_salary,
        split_part(job_salary, ' ', -1) AS pay_unit,
        search_term,
        search_date,
        search_time AS searched_at
    FROM source
)

SELECT * FROM cleaned