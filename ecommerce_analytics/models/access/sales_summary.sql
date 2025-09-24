with sales as (
    select 
        InvoiceNo,
        CustomerID,
        quantity,
        UnitPrice,
        discount,
        InvoiceDate,
        transaction_type,
        round((quantity * UnitPrice) - discount, 2) as net_sales
    from {{ ref('fact_sales') }}
)

select
    date_trunc('day', InvoiceDate) as order_date,
    transaction_type,
    sum(net_sales) as net_revenue,
    COUNT(DISTINCT CASE WHEN transaction_type = 'sale' THEN InvoiceNo END) AS total_sold,
    COUNT(DISTINCT CASE WHEN transaction_type = 'return' THEN InvoiceNo END) AS total_returns,
    round(SUM(CASE WHEN transaction_type = 'sale' THEN net_sales ELSE 0 END), 2) AS gross_sales,
    round(SUM(CASE WHEN transaction_type = 'return' THEN net_sales ELSE 0 END), 2) AS return_amount,
    count(distinct InvoiceNo) as total_orders,
    count(distinct CustomerID) as unique_customers,
    round(avg(net_sales), 2) as avg_order_value,
    try_divide(SUM(CASE WHEN transaction_type = 'return' THEN net_sales ELSE 0 END),
                SUM(CASE WHEN transaction_type = 'sale' THEN net_sales ELSE 1 END)) AS return_rate
from sales
group by 1, 2
order by 1
