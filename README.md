## 

## Trust Report

What the auditor found in the job postings data, and the guard that now catches each problem.

| Data problem | Guard | Count |
|---|---|---|
| Scraper error rows | stg_postings filter + unit test test_staging_filters | 151,147 error rows |
| Postings with no job_id | stg_postings filter + unique and not_null on int_job_scrapes.job_id | 6,255 id-less rows (Dec 2025 to Apr 2026) |
| Re-scraped jobs | int_job_scrapes + analysis rescrape_profile | 87.1% of jobs scraped once |
| Re-scrapes skew remote share | analysis remote_check (count jobs, not scrapes) | Data Analyst 6.9% remote by scrapes vs 5.1% by jobs |
| Job boards posing as employers | seed job_boards + analysis job_board_share | Jobs via Dice 14,904 jobs |
| NULL remote flag | is_remote from FROM_JSON + macro null_check | 646,341 NULL remote flags down to 45 |
| Missing locations | not_null on stg_postings.job_location (warn) | 2,440 missing locations |
| Jobs with no skills | relationships int_job_scrapes to stg_skills (warn) | 65,039 jobs without skills |
| Duplicate skill pairs | int_skill_pairs + singular test assert_unique_skill_pairs | 132,313 duplicate skill pairs |
| Thin scrape days | singular test assert_no_thin_days (warn) | 2 thin days |
| Term changes | snapshot job_terms_snapshot | 177 term versions closed in the August and September runs |