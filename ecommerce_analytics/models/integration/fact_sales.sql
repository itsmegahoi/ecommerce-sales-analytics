SELECT
    CustomerID,
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    CASE 
    WHEN lower(s.Description) = 'discount' THEN s.UnitPrice
    ELSE
    round(try_divide(p.price, p.quantity_sold), 2) 
    END AS UnitPrice,
    CASE
     WHEN lower(s.Description) = 'discount' THEN round(abs(s.quantity * s.UnitPrice), 2)
     ELSE 0
    END AS discount,
    case 
        when s.quantity < 0 AND lower(s.Description) <> 'discount' then 'return'
        else 'sale'
    end as transaction_type,
    abs(round(s.quantity * try_divide(p.price, p.quantity_sold), 2)) as revenue
FROM {{ref('stg_sales')}} AS s
LEFT JOIN
{{ref('stg_products')}} AS p ON s.Description = p.product_name