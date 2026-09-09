DO $$
DECLARE
    r record;
    expected jsonb := '{"ABJ-WUS":330000.00,"IBA-DUG":121700.00,"KAN-CEN":62200.00,"LOS-IKE":43000.00,"PHC-GRA":57700.00}'::jsonb;
BEGIN
    FOR r IN
        WITH line_totals AS (
            SELECT order_id, SUM(quantity * unit_price - discount_amount) AS line_total
            FROM order_items
            GROUP BY order_id
        )
        SELECT
            b.branch_code,
            SUM(lt.line_total - o.discount_amount)::numeric(14,2) AS net_value
        FROM orders AS o
        JOIN line_totals AS lt ON lt.order_id = o.order_id
        JOIN branches AS b ON b.branch_id = o.branch_id
        WHERE o.order_status = 'completed'
        GROUP BY b.branch_code
    LOOP
        IF NOT expected ? r.branch_code THEN
            RAISE EXCEPTION 'unexpected branch % in capstone total', r.branch_code;
        END IF;
        IF (expected ->> r.branch_code)::numeric(14,2) <> r.net_value THEN
            RAISE EXCEPTION 'branch % value %, expected %', r.branch_code, r.net_value, expected ->> r.branch_code;
        END IF;
        expected := expected - r.branch_code;
    END LOOP;

    IF expected <> '{}'::jsonb THEN
        RAISE EXCEPTION 'missing expected branches: %', expected;
    END IF;
END $$;
