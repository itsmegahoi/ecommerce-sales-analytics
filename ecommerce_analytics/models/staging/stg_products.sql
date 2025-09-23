{{ config(materialized = 'view') }}

SELECT
    abs(cast(conv(substr(sha2(product_name, 256), 1, 15), 16, 10) as bigint)) as product_id,
    product_name,
    price,
    quantity_sold,
    manufacturer,
    release_date,
    customer_rating,
    in_stock
FROM {{ source('ecommerce', 'products') }}
WHERE product_name IS NOT NULL
