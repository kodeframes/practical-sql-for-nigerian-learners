SELECT
    o.order_number,
    c.customer_name,
    b.branch_name
FROM orders AS o
LEFT JOIN customers AS c ON c.customer_id = o.customer_id
JOIN branches AS b ON b.branch_id = o.branch_id
ORDER BY o.order_id;

WITH line_totals AS (
    SELECT
        order_id,
        SUM(quantity * unit_price - discount_amount) AS line_total
    FROM order_items
    GROUP BY order_id
)
SELECT
    o.order_number,
    lt.line_total,
    o.discount_amount AS order_discount,
    lt.line_total - o.discount_amount AS order_net_value
FROM orders AS o
JOIN line_totals AS lt ON lt.order_id = o.order_id
ORDER BY o.order_id;
