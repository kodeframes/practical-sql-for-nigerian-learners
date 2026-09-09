SELECT
    sp.supplier_id,
    s.supplier_name,
    sp.product_id,
    p.product_name,
    sp.is_preferred
FROM supplier_products AS sp
JOIN suppliers AS s ON s.supplier_id = sp.supplier_id
JOIN products AS p ON p.product_id = sp.product_id
ORDER BY sp.supplier_id, sp.product_id;

SELECT o.order_number, c.customer_name
FROM orders AS o
LEFT JOIN customers AS c ON c.customer_id = o.customer_id
ORDER BY o.order_id;
