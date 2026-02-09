{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='HASH_KEY'
    )
}}
SELECT
    '{{ invocation_id }}' AS invocation_id
    , *
FROM 
    {{ source('btc', 'btc') }}
{% if is_incremental() %}
WHERE 1=1
    AND BLOCK_TIMESTAMP >= (SELECT MAX(BLOCK_TIMESTAMP) FROM {{ this }})
{% endif %}