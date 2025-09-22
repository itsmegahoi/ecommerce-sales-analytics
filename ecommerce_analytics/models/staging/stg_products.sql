{{ config(materialized = 'view')}}

SELECT monotonically_increasing_id() as product_id,
    product_name,
    price,
    quantity_sold,
    manufacturer,
    release_date,
    customer_rating,
    in_stock
FROM {{source('ecommerce', 'products')}}
WHERE product_id IS NOT NULL