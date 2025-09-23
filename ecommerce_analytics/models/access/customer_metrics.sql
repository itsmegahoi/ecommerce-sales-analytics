with customer_sales as (
    select
        CustomerID,
        sum((quantity * UnitPrice) - discount) as total_spent,
        count(distinct InvoiceNo) as total_orders,
        min(InvoiceDate) as first_order_date,
        max(InvoiceDate) as last_order_date
    from {{ ref('fact_sales') }}
    group by CustomerID
)

select
    CustomerID,
    total_spent,
    total_orders,
    total_spent / nullif(total_orders, 0) as avg_order_value,
    datediff(last_order_date, first_order_date) as customer_lifespan_days
from customer_sales
