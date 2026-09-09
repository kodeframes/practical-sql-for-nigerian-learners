WITH line_totals AS (
    SELECT
        order_id,
        SUM(quantity * unit_price - discount_amount) AS line_total
    FROM order_items
    GROUP BY order_id
),
order_totals AS (
    SELECT
        o.order_id,
        o.order_number,
        o.branch_id,
        o.order_date,
        line_totals.line_total - o.discount_amount AS order_net_value
    FROM orders AS o
    JOIN line_totals ON line_totals.order_id = o.order_id
    WHERE o.order_status = 'completed'
)
SELECT
    branch_id,
    COUNT(*) AS completed_orders,
    SUM(order_net_value) AS completed_order_value
FROM order_totals
GROUP BY branch_id
ORDER BY branch_id;
