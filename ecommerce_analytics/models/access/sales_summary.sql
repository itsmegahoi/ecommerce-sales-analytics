with sales as (
    select 
        InvoiceNo,
        CustomerID,
        quantity,
        UnitPrice,
        discount,
        InvoiceDate,
        transaction_type,
        (quantity * UnitPrice) - discount as net_sales
    from {{ ref('fact_sales') }}
)

select
    date_trunc('day', InvoiceDate) as order_date,
    sum(net_sales) as net_revenue,
    SUM(CASE WHEN transaction_type = 'sale' THEN net_sales ELSE 0 END) AS total_sales,
    SUM(CASE WHEN transaction_type = 'return' THEN net_sales ELSE 0 END) AS total_returns,
    count(distinct InvoiceNo) as total_orders,
    count(distinct CustomerID) as unique_customers,
    avg(net_sales) as avg_order_value
from sales
group by 1
order by 1
