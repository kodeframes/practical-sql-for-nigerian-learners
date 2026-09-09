SELECT
    customer_id,
    UPPER(customer_name) AS customer_name_upper,
    LENGTH(TRIM(customer_name)) AS name_length
FROM customers
ORDER BY customer_id;

SELECT
    order_number,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month
FROM orders
ORDER BY order_date, order_id;

SELECT DATE '2026-03-31' - DATE '2026-03-01' AS days_between;
