{{config(materialized = 'view')}}

SELECT 
    InvoiceNo, 
    StockCode, 
    Description, 
    Quantity, 
    InvoiceDate, 
    UnitPrice, 
    CustomerID 
FROM 
    {{source('ecommerce', 'sales')}}
WHERE CustomerID IS NOT NULL