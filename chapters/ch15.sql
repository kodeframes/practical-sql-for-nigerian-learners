WITH product_sales AS (
    SELECT
        oi.product_id,
        SUM(oi.quantity) AS units_sold
    FROM order_items AS oi
    JOIN orders AS o ON o.order_id = oi.order_id
    WHERE o.order_status = 'completed'
    GROUP BY oi.product_id
)
SELECT
    p.product_id,
    p.product_name,
    ps.units_sold,
    RANK() OVER (ORDER BY ps.units_sold DESC) AS sales_rank,
    DENSE_RANK() OVER (ORDER BY ps.units_sold DESC) AS dense_sales_rank
FROM product_sales AS ps
JOIN products AS p ON p.product_id = ps.product_id
ORDER BY sales_rank, p.product_id;

SELECT
    payment_id,
    payment_date,
    amount,
    SUM(amount) OVER (
        ORDER BY payment_date, payment_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_attempted_payment_total
FROM payments
ORDER BY payment_date, payment_id;
