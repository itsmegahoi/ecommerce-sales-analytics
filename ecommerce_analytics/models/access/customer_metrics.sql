with customer_sales as (
    select
        CustomerID,
        round(sum((quantity * UnitPrice) - discount), 2) as total_spent,
        COUNT(DISTINCT CASE WHEN transaction_type = 'sale' THEN InvoiceNo END) AS total_sold,
        COUNT(DISTINCT CASE WHEN transaction_type = 'return' THEN InvoiceNo END) AS total_returns,
        count(distinct InvoiceNo) as total_orders,
        min(InvoiceDate) as first_order_date,
        max(InvoiceDate) as last_order_date,
        round(SUM(CASE WHEN transaction_type = 'return' THEN (quantity * UnitPrice) - discount ELSE 0 END), 2) AS return_amount,
        round(SUM(CASE WHEN transaction_type = 'sale' THEN (quantity * UnitPrice) - discount ELSE 1 END), 2) AS gross_sales
    from {{ ref('fact_sales') }}
    group by CustomerID
)

select
    CustomerID,
    total_spent,
    total_sold,
    total_returns
    total_orders,
    round(total_spent / nullif(total_orders, 0), 2) as avg_order_value,
    datediff(last_order_date, first_order_date) as customer_lifespan_days,
    round(try_divide(return_amount, gross_sales), 2) AS customer_return_rate
from customer_sales
