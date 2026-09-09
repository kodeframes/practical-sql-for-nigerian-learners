DO $$
DECLARE
    before_count bigint;
    after_count bigint;
BEGIN
    SELECT COUNT(*) INTO before_count FROM customers;

    BEGIN
        INSERT INTO customers (customer_name, customer_type, city, state)
        VALUES ('Rollback Verification Customer', 'individual', 'Ibadan', 'Oyo');
        RAISE EXCEPTION USING ERRCODE = 'P0001', MESSAGE = 'force rollback';
    EXCEPTION
        WHEN SQLSTATE 'P0001' THEN
            NULL;
    END;

    SELECT COUNT(*) INTO after_count FROM customers;
    IF before_count <> after_count THEN
        RAISE EXCEPTION 'subtransaction rollback failed: before %, after %', before_count, after_count;
    END IF;
END $$;
