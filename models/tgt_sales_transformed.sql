{{
    config(
        materialized='table'
    )
}}

WITH sales_data AS (
    SELECT 
        t.region, 
        t.sales, 
        t.currency, 
        c.rate_to_usd, 
        t.sales * c.rate_to_usd AS sales_in_usd
    FROM TGT t
    LEFT JOIN CURRENCY_RATES c
    ON t.currency = c.currency
)

SELECT 
    region, 
    SUM(sales_in_usd) AS total_sales_usd
FROM sales_data
GROUP BY region
