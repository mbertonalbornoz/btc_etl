{{
    config(
        materialized='ephemeral'
    )
}}
SELECT
    *
FROM
    {{ ref('stg_btc_outputs') }}
WHERE 1=1
    AND is_coinbase = false