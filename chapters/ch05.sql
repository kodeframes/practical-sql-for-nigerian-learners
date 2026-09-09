SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price BETWEEN 3000 AND 10000
ORDER BY product_id;

SELECT order_number, order_date, order_status
FROM orders
WHERE order_status IN ('completed', 'pending')
  AND order_date >= DATE '2026-02-01'
ORDER BY order_date, order_number;

SELECT customer_id, customer_name, email
FROM customers
WHERE email IS NULL
ORDER BY customer_id;
