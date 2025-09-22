SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    try_divide(p.price, p.quantity_sold) AS UnitPrice,
    s.quantity * try_divide(p.price, p.quantity_sold) as revenue,
    CustomerID
FROM {{ref('stg_sales')}} AS s
LEFT JOIN
{{ref('stg_products')}} AS p ON s.Description = p.product_name