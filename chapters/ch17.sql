BEGIN;

CREATE TEMP TABLE customer_status_practice AS
SELECT customer_id, customer_name, is_active
FROM customers;

SELECT customer_id, customer_name, is_active
FROM customer_status_practice
WHERE is_active = false
ORDER BY customer_id;

UPDATE customer_status_practice
SET is_active = true
WHERE is_active = false
RETURNING customer_id, customer_name, is_active;

SELECT COUNT(*) AS active_rows
FROM customer_status_practice
WHERE is_active = true;

ROLLBACK;
