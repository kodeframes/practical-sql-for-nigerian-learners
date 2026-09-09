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
    b.branch_code,
    b.branch_name,
    COUNT(*) AS completed_orders,
    SUM(ot.order_net_value) AS completed_order_value
FROM order_totals AS ot
JOIN branches AS b ON b.branch_id = ot.branch_id
GROUP BY b.branch_code, b.branch_name
ORDER BY completed_order_value DESC, b.branch_code;

SELECT c.customer_id, c.customer_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1 FROM orders AS o WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;

WITH stock_position AS (
    SELECT branch_id, product_id, SUM(quantity_change) AS quantity_on_hand
    FROM inventory_movements
    GROUP BY branch_id, product_id
)
SELECT
    b.branch_code,
    p.sku,
    sp.quantity_on_hand,
    p.reorder_level
FROM stock_position AS sp
JOIN branches AS b ON b.branch_id = sp.branch_id
JOIN products AS p ON p.product_id = sp.product_id
WHERE sp.quantity_on_hand <= p.reorder_level
ORDER BY b.branch_code, p.sku;
