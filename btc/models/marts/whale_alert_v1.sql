WITH whales AS (SELECT
                    output_address
                    , SUM(output_value) AS total_sent
                    , COUNT(*)          AS t_count
                FROM
                    {{ ref('stg_btc_transactions') }}
                WHERE 1 = 1
                  AND output_value > 10
                GROUP BY
                    output_address
                ORDER BY
                    SUM(output_value) DESC)
SELECT w.output_address
     , w.total_sent
     , w.t_count
     , {{ convert_to_usd('w.total_sent') }} AS total_sent_usd
FROM WHALES AS w
ORDER BY total_sent DESC