{{ config(materialized = 'view')}}

SELECT * FROM {{source('ecommerce', 'products')}}
WHERE product_id IS NOT NULL