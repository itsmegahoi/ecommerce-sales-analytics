WITH deduplicated_customers AS (
  SELECT *
  FROM (
    SELECT *,
      row_number() OVER (
        PARTITION BY customer_id
        ORDER BY last_updated DESC
      ) AS latest_rec
    FROM {{ref('stg_customers')}}
    WHERE customer_id IN (
      SELECT customer_id
      FROM {{ref('stg_customers')}}
      GROUP BY customer_id
      HAVING COUNT(email) > 1
    )
    ORDER BY customer_id
  )
  WHERE latest_rec = 1
)
SELECT
  customer_id,
  first_name,
  last_name,
  email,
  phone_number,
  address,
  city,
  country,
  postal_code,
  membership_status,
  last_updated
FROM
  deduplicated_customers
UNION
SELECT * FROM {{ref('stg_customers')}}
    WHERE customer_id IN (
      SELECT customer_id
      FROM {{ref('stg_customers')}}
      GROUP BY customer_id
      HAVING COUNT(email) = 1
    )