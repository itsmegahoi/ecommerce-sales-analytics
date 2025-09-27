WITH sales_cte AS (
    SELECT
        dc.city,
        dc.country,
        fs.transaction_type,
        ROUND(SUM((fs.quantity * fs.UnitPrice) - fs.discount), 2) AS total_sales,
        COUNT(DISTINCT fs.InvoiceNo) AS total_orders,
        COUNT(DISTINCT fs.CustomerID) AS total_customers
    FROM {{ ref('fact_sales') }} AS fs
    LEFT JOIN {{ ref('dim_customers') }} AS dc
        ON dc.customer_id = fs.CustomerID
    GROUP BY dc.city, dc.country, fs.transaction_type
)

SELECT
    city,
    country,
    SUM(CASE WHEN transaction_type = 'sale' THEN total_sales ELSE 0 END) AS gross_sales,
    SUM(CASE WHEN transaction_type = 'return' THEN total_sales ELSE 0 END) AS return_amount,
    SUM(total_sales) AS net_sales,
    SUM(total_orders) AS total_orders,
    SUM(total_customers) AS total_customers
FROM sales_cte
GROUP BY city, country
ORDER BY net_sales DESC;
