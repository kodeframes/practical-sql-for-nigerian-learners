DO $$
DECLARE
    v_id integer;
BEGIN
    INSERT INTO categories (category_name)
    VALUES ('Sequence Verification Category')
    RETURNING category_id INTO v_id;

    IF v_id <= 4 THEN
        RAISE EXCEPTION 'category identity sequence returned %, expected > 4', v_id;
    END IF;

    DELETE FROM categories WHERE category_id = v_id;
END $$;
