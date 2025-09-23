{{config(materialized = 'view')}}

SELECT 
    InvoiceNo, 
    StockCode, 
    Description, 
    Quantity, 
    try_to_timestamp(InvoiceDate, 'M/d/yyyy H:mm') as InvoiceDate,
    UnitPrice, 
    CustomerID 
FROM 
    {{source('ecommerce', 'sales')}}
WHERE CustomerID IS NOT NULL