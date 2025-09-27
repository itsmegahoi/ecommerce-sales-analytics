WITH product_sales AS (
    SELECT
        dp.product_id,
        dp.product_name,
        dp.manufacturer,
        fs.transaction_type,
        SUM((fs.quantity * fs.UnitPrice) - fs.discount) AS total_revenue
    FROM {{ ref('fact_sales') }} fs
    INNER JOIN {{ ref('dim_products') }} dp
        ON fs.Description = dp.product_name
    GROUP BY dp.product_id, dp.product_name, dp.manufacturer, fs.transaction_type
)

SELECT
    product_id,
    product_name,
    manufacturer,
    ROUND(SUM(CASE WHEN transaction_type = 'sale' THEN total_revenue ELSE 0 END), 2) AS gross_sales,
    ROUND(SUM(CASE WHEN transaction_type = 'return' THEN total_revenue ELSE 0 END), 2) AS total_returns,
    ROUND(SUM(total_revenue), 2) AS net_sales,
    RANK() OVER (ORDER BY SUM(total_revenue) DESC) AS revenue_rank
FROM product_sales
GROUP BY product_id, product_name, manufacturer
ORDER BY net_sales DESC;
