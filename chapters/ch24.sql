-- Interview-style verification examples.
SELECT c.customer_id, c.customer_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1 FROM orders AS o WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;

SELECT
    o.branch_id,
    COUNT(*) AS completed_orders
FROM orders AS o
WHERE o.order_status = 'completed'
GROUP BY o.branch_id
ORDER BY o.branch_id;

SELECT version();
