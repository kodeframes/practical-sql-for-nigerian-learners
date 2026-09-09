DO $$
DECLARE
    v_count bigint;
BEGIN
    SELECT COUNT(*) INTO v_count FROM branches;
    IF v_count <> 6 THEN RAISE EXCEPTION 'branches count %, expected 6', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM employees;
    IF v_count <> 8 THEN RAISE EXCEPTION 'employees count %, expected 8', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM customers;
    IF v_count <> 10 THEN RAISE EXCEPTION 'customers count %, expected 10', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM suppliers;
    IF v_count <> 4 THEN RAISE EXCEPTION 'suppliers count %, expected 4', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM categories;
    IF v_count <> 4 THEN RAISE EXCEPTION 'categories count %, expected 4', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM products;
    IF v_count <> 12 THEN RAISE EXCEPTION 'products count %, expected 12', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM orders;
    IF v_count <> 12 THEN RAISE EXCEPTION 'orders count %, expected 12', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM order_items;
    IF v_count <> 22 THEN RAISE EXCEPTION 'order_items count %, expected 22', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM payments;
    IF v_count <> 13 THEN RAISE EXCEPTION 'payments count %, expected 13', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM inventory_movements;
    IF v_count <> 13 THEN RAISE EXCEPTION 'inventory_movements count %, expected 13', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM deliveries;
    IF v_count <> 8 THEN RAISE EXCEPTION 'deliveries count %, expected 8', v_count; END IF;
    SELECT COUNT(*) INTO v_count FROM returns;
    IF v_count <> 2 THEN RAISE EXCEPTION 'returns count %, expected 2', v_count; END IF;
END $$;
