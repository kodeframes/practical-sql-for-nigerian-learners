BEGIN;

CREATE TEMP TABLE poor_order_sheet (
    order_number text,
    customer_name text,
    customer_city text,
    product_1 text,
    product_1_qty integer,
    product_2 text,
    product_2_qty integer
);

INSERT INTO poor_order_sheet VALUES
('DEMO-1', 'Example Customer', 'Ibadan', 'A4 Paper Ream', 2, 'USB Flash Drive 64GB', 1);

SELECT * FROM poor_order_sheet;

ROLLBACK;
