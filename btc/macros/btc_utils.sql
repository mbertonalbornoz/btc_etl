{% macro convert_to_usd(column_name) %}
{{ column_name }} * (
    SELECT
        price
    FROM
        {{ ref('btc_usd_max') }}
    WHERE 1=1
        AND TO_DATE(REPLACE(snapped_at, ' UTC', '')) = CURRENT_DATE()
)
{% endmacro %}