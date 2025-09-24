SELECT
    dc.city,
    dc.country,
    round((SUM((fs.quantity * fs.UnitPrice) - fs.discount)), 2) AS total_sales,
    COUNT(DISTINCT fs.InvoiceNo) AS total_orders,
    COUNT(DISTINCT fs.CustomerID) AS total_customers
FROM {{ref('fact_sales')}} AS fs
LEFT JOIN
{{ref('dim_customers')}} AS dc
ON dc.customer_id = fs.CustomerID
GROUP BY dc.country, dc.city
ORDER BY total_sales DESC