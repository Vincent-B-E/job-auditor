{% set columns = ['job_id', 'job_location', 'job_schedule_type', 'job_salary', 'is_remote'] -%}

{% for column in columns -%}
{{ null_check(table='stg_postings', column=column) }}
{{ "UNION ALL" if not loop.last }}
{% endfor %}