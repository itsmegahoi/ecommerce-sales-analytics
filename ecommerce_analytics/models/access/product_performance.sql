with product_sales as (
    select
        dp.product_id,
        dp.manufacturer,
        sum(dp.quantity_sold) OVER (PARTITION BY product_id) as total_quantity_sold,
        sum((dp.quantity_sold * fs.UnitPrice) - fs.discount) OVER (PARTITION BY product_id) as total_revenue
    from {{ ref('fact_sales') }} fs
    INNER JOIN {{ ref('dim_products')}} dp
    ON fs.Description = dp.product_name
)

select
  DISTINCT
    product_id,
    manufacturer,
    total_quantity_sold,
    round(total_revenue, 2) AS total_revenue,
    rank() over (order by total_revenue desc) as revenue_rank
from product_sales
