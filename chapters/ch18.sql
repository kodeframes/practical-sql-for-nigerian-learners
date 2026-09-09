BEGIN;

CREATE TEMP TABLE inventory_balance_practice (
    product_id integer PRIMARY KEY,
    quantity_on_hand integer NOT NULL CHECK (quantity_on_hand >= 0)
);

INSERT INTO inventory_balance_practice (product_id, quantity_on_hand)
VALUES (1, 5);

SAVEPOINT before_change;
UPDATE inventory_balance_practice
SET quantity_on_hand = quantity_on_hand - 1
WHERE product_id = 1;

SELECT product_id, quantity_on_hand
FROM inventory_balance_practice;

ROLLBACK TO SAVEPOINT before_change;
SELECT product_id, quantity_on_hand
FROM inventory_balance_practice;

ROLLBACK;
