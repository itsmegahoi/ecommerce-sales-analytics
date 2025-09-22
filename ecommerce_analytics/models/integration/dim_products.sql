SELECT
    product_id,
    product_name,
    price,
    quantity_sold,
    manufacturer,
    customer_rating,
    in_stock
FROM {{ref('stg_products')}}