BEGIN;

CREATE TEMP VIEW active_products_view AS
SELECT product_id, product_name, unit_price
FROM products
WHERE is_active = true;

SELECT product_id, product_name, unit_price
FROM active_products_view
ORDER BY product_id;

EXPLAIN
SELECT order_id, order_number, order_date
FROM orders
WHERE branch_id = 1
ORDER BY order_date;

EXPLAIN ANALYZE
SELECT order_id, order_number, order_date
FROM orders
WHERE branch_id = 1
ORDER BY order_date;

ROLLBACK;
