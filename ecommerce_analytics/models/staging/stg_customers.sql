{{config(materialized = 'view')}}

SELECT * FROM 
    {{source('ecommerce', 'customers')}}
WHERE customer_id IS NOT NULL