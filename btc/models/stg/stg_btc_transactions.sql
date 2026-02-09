{{
    config(
        materialized='ephemeral'
    )
}}
SELECT
    '{{ invocation_id }}' AS invocation_id
    , *
FROM
    {{ ref('stg_btc_outputs') }}
WHERE 1=1
    AND is_coinbase = false