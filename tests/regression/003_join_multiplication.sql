DO $$
DECLARE
    v_naive numeric(14,2);
    v_correct numeric(14,2);
BEGIN
    -- Deliberately naive: successful payments can multiply order-item rows.
    SELECT SUM(oi.quantity * oi.unit_price - oi.discount_amount)
    INTO v_naive
    FROM orders AS o
    JOIN order_items AS oi ON oi.order_id = o.order_id
    JOIN payments AS p ON p.order_id = o.order_id
    WHERE o.order_status = 'completed'
      AND p.payment_status = 'successful';

    WITH line_totals AS (
        SELECT order_id, SUM(quantity * unit_price - discount_amount) AS line_total
        FROM order_items
        GROUP BY order_id
    )
    SELECT SUM(lt.line_total)
    INTO v_correct
    FROM orders AS o
    JOIN line_totals AS lt ON lt.order_id = o.order_id
    WHERE o.order_status = 'completed';

    IF v_naive <> 638750.00 THEN
        RAISE EXCEPTION 'naive multiplied value %, expected 638750.00', v_naive;
    END IF;
    IF v_correct <> 618150.00 THEN
        RAISE EXCEPTION 'correct line-grain value %, expected 618150.00', v_correct;
    END IF;
    IF v_naive = v_correct THEN
        RAISE EXCEPTION 'join multiplication test failed to demonstrate a difference';
    END IF;
END $$;
