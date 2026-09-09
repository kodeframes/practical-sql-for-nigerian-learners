SELECT product_id, product_name, unit_price
FROM products
ORDER BY unit_price DESC, product_id
LIMIT 5;

SELECT DISTINCT state
FROM customers
WHERE state IS NOT NULL
ORDER BY state;

SELECT order_number, order_date
FROM orders
ORDER BY order_date DESC, order_id DESC
LIMIT 3;
