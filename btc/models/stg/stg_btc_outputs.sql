{{
    config(
        materialized='incremental',
        incremental_strategy='append',
    )
}}
WITH flattened_outputs AS (
SELECT t.hash_key
    , t.block_number
    , t.block_timestamp
    , t.is_coinbase
    , f.value: address::STRING AS output_address
    , f.value: value::FLOAT AS output_value
FROM {{ ref('stg_btc')}} AS t,
LATERAL FLATTEN(input => outputs) AS f
WHERE 1=1
    AND f.value:address IS NOT NULL

{% if is_incremental() %}
    AND t.block_timestamp > (SELECT MAX(block_timestamp) FROM  {{ this }})
{% endif %}
)

SELECT
    hash_key
    , block_number
    , block_timestamp
    , is_coinbase
    , output_address
    , output_value
FROM
    flattened_outputs