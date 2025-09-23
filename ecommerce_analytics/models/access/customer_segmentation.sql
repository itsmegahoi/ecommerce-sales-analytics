with customer_rfm as (
    select
        CustomerID,
        max(InvoiceDate) as last_order_date,
        count(distinct InvoiceNo) as frequency,
        sum((quantity * UnitPrice) - discount) as monetary
    from {{ ref('fact_sales') }}
    group by CustomerID
)

select
    CustomerID,
    datediff(max(last_order_date) over (), last_order_date) as recency_days,
    frequency,
    monetary,
    case 
        when monetary > 1000 then 'High Value'
        when monetary between 500 and 1000 then 'Medium Value'
        else 'Low Value'
    end as customer_segment
from customer_rfm
