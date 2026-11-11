WITH source AS (
    SELECT *
    FROM {{ source('jobs', 'raw_job_postings') }}
    WHERE error IS NOT TRUE
),

cleaned AS (
    SELECT
        job_id,
        job_title,
        company_name,
        job_location,
        REGEXP_REPLACE(job_via, '^via ', '') AS source_platform,
        job_schedule_type,
        job_work_from_home,
        job_salary,
        split_part(job_salary, ' ', -1) AS pay_unit,
        search_term,
        search_date,
        search_time AS searched_at
    FROM source
)

SELECT * FROM cleaned