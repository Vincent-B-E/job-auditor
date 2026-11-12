{{ config(materialized='ephemeral') }}

SELECT
    job_id,
    search_term,
    company_name,
    job_title,
    job_schedule_type,
    is_remote,
    searched_at
FROM {{ ref('stg_postings') }}
WHERE search_date <= CAST('{{ var('as_of', run_started_at) }}' AS DATE)

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY job_id
    ORDER BY searched_at DESC
) = 1