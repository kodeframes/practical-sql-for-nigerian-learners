DO $$
DECLARE
    v_count bigint;
    v_amount numeric(14,2);
BEGIN
    SELECT COUNT(*) INTO v_count FROM orders WHERE order_status = 'completed';
    IF v_count <> 10 THEN RAISE EXCEPTION 'completed order count %, expected 10', v_count; END IF;

    SELECT COUNT(*) INTO v_count FROM payments WHERE payment_status = 'failed';
    IF v_count <> 1 THEN RAISE EXCEPTION 'failed payment count %, expected 1', v_count; END IF;

    SELECT SUM(amount) INTO v_amount FROM payments WHERE payment_status = 'successful';
    IF v_amount <> 613800.00 THEN RAISE EXCEPTION 'successful payment amount %, expected 613800.00', v_amount; END IF;

    SELECT COUNT(*) INTO v_count FROM deliveries WHERE delivery_status = 'delivered';
    IF v_count <> 6 THEN RAISE EXCEPTION 'delivered count %, expected 6', v_count; END IF;
END $$;
