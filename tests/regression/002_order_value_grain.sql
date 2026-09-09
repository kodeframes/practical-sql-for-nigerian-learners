DO $$
DECLARE
    v_line_total numeric(14,2);
    v_net_total numeric(14,2);
BEGIN
    SELECT SUM(oi.quantity * oi.unit_price - oi.discount_amount)
    INTO v_line_total
    FROM order_items AS oi
    JOIN orders AS o ON o.order_id = oi.order_id
    WHERE o.order_status = 'completed';

    IF v_line_total <> 618150.00 THEN
        RAISE EXCEPTION 'completed line total %, expected 618150.00', v_line_total;
    END IF;

    WITH line_totals AS (
        SELECT order_id, SUM(quantity * unit_price - discount_amount) AS line_total
        FROM order_items
        GROUP BY order_id
    )
    SELECT SUM(lt.line_total - o.discount_amount)
    INTO v_net_total
    FROM orders AS o
    JOIN line_totals AS lt ON lt.order_id = o.order_id
    WHERE o.order_status = 'completed';

    IF v_net_total <> 614600.00 THEN
        RAISE EXCEPTION 'completed net order value %, expected 614600.00', v_net_total;
    END IF;
END $$;
