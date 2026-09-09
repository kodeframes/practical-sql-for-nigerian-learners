-- Expected: every query returns zero rows unless noted otherwise.

SELECT o.order_id FROM orders AS o LEFT JOIN branches AS b ON b.branch_id = o.branch_id WHERE b.branch_id IS NULL;
SELECT oi.order_item_id FROM order_items AS oi LEFT JOIN orders AS o ON o.order_id = oi.order_id WHERE o.order_id IS NULL;
SELECT oi.order_item_id FROM order_items AS oi LEFT JOIN products AS p ON p.product_id = oi.product_id WHERE p.product_id IS NULL;
SELECT sp.supplier_id, sp.product_id FROM supplier_products AS sp LEFT JOIN suppliers AS s ON s.supplier_id = sp.supplier_id LEFT JOIN products AS p ON p.product_id = sp.product_id WHERE s.supplier_id IS NULL OR p.product_id IS NULL;
SELECT order_item_id FROM order_items WHERE quantity <= 0 OR unit_price < 0 OR discount_amount < 0 OR discount_amount > quantity * unit_price;
SELECT movement_id FROM inventory_movements WHERE quantity_change = 0;

-- Expected: one row with 12 orders in the seed dataset.
SELECT COUNT(*) AS order_count FROM orders;
