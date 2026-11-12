{{ config(severity='warn') }}

SELECT
    search_date,
    postings
FROM {{ ref('fct_daily_scrapes') }}
WHERE postings < 100
ORDER BY search_date