DO $$
DECLARE
    v_count bigint;
BEGIN
    SELECT COUNT(*) INTO v_count FROM customers WHERE email IS NULL;
    IF v_count <> 4 THEN RAISE EXCEPTION 'NULL email count %, expected 4', v_count; END IF;

    SELECT COUNT(*) INTO v_count
    FROM customers AS c
    WHERE NOT EXISTS (
        SELECT 1 FROM orders AS o WHERE o.customer_id = c.customer_id
    );
    IF v_count <> 1 THEN RAISE EXCEPTION 'customers with no orders %, expected 1', v_count; END IF;

    SELECT COUNT(*) INTO v_count
    FROM products AS p
    WHERE NOT EXISTS (
        SELECT 1 FROM order_items AS oi WHERE oi.product_id = p.product_id
    );
    IF v_count <> 1 THEN RAISE EXCEPTION 'unsold products %, expected 1', v_count; END IF;

    SELECT COUNT(*) INTO v_count
    FROM orders AS o
    WHERE NOT EXISTS (
        SELECT 1 FROM payments AS p
        WHERE p.order_id = o.order_id
          AND p.payment_status = 'successful'
    );
    IF v_count <> 2 THEN RAISE EXCEPTION 'orders without successful payment %, expected 2', v_count; END IF;
END $$;
