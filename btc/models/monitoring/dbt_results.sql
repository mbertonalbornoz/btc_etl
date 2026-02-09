{{ config(
        materialized='incremental',
        transient='false',
        unique_key='result_id'
    )
}}
WITH empty_table AS (
    SELECT
        NULL AS result_id
        , NULL AS invocation_id
        , NULL AS unique_id
        , NULL AS database_name
        , NULL AS schema_name
        , NULL AS name
        , NULL AS resource_type
        , NULL AS status
        , CAST(NULL AS FLOAT) AS execution_time
        , CAST(NULL AS INT) AS rows_affected
)
SELECT
    *
FROM
    empty_table
WHERE 1=0