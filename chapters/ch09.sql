SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_status;

SELECT payment_status, COUNT(*) AS payment_count, SUM(amount) AS total_attempted_amount
FROM payments
GROUP BY payment_status
ORDER BY payment_status;

SELECT sales_channel, COUNT(*) AS order_count
FROM orders
GROUP BY sales_channel
HAVING COUNT(*) >= 2
ORDER BY sales_channel;
