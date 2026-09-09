BEGIN;

CREATE TEMP TABLE students (
    student_id bigint PRIMARY KEY,
    student_name text NOT NULL
);
CREATE TEMP TABLE academic_terms (
    term_id bigint PRIMARY KEY,
    academic_year text NOT NULL,
    term_name text NOT NULL
);
CREATE TEMP TABLE invoices (
    invoice_id bigint PRIMARY KEY,
    student_id bigint NOT NULL REFERENCES students(student_id),
    term_id bigint NOT NULL REFERENCES academic_terms(term_id),
    amount_due numeric(12,2) NOT NULL CHECK (amount_due >= 0)
);
CREATE TEMP TABLE school_payments (
    payment_id bigint PRIMARY KEY,
    invoice_id bigint NOT NULL REFERENCES invoices(invoice_id),
    amount numeric(12,2) NOT NULL CHECK (amount >= 0)
);

INSERT INTO students VALUES (1, 'Student One'), (2, 'Student Two');
INSERT INTO academic_terms VALUES (1, '2025/2026', 'First Term');
INSERT INTO invoices VALUES (1, 1, 1, 120000.00), (2, 2, 1, 120000.00);
INSERT INTO school_payments VALUES (1, 1, 70000.00), (2, 1, 50000.00), (3, 2, 30000.00);

WITH invoice_payments AS (
    SELECT invoice_id, SUM(amount) AS amount_paid
    FROM school_payments
    GROUP BY invoice_id
)
SELECT
    s.student_name,
    i.amount_due,
    COALESCE(ip.amount_paid, 0) AS amount_paid,
    i.amount_due - COALESCE(ip.amount_paid, 0) AS outstanding_balance
FROM invoices AS i
JOIN students AS s ON s.student_id = i.student_id
LEFT JOIN invoice_payments AS ip ON ip.invoice_id = i.invoice_id
ORDER BY s.student_id;

CREATE TEMP TABLE drivers (
    driver_id bigint PRIMARY KEY,
    driver_name text NOT NULL
);
CREATE TEMP TABLE logistics_deliveries (
    delivery_id bigint PRIMARY KEY,
    driver_id bigint NOT NULL REFERENCES drivers(driver_id),
    delivery_status text NOT NULL,
    dispatched_at timestamptz,
    completed_at timestamptz
);

INSERT INTO drivers VALUES (1, 'Driver One'), (2, 'Driver Two');
INSERT INTO logistics_deliveries VALUES
(1, 1, 'delivered', '2026-03-01 08:00+01', '2026-03-01 12:00+01'),
(2, 1, 'failed', '2026-03-02 09:00+01', NULL),
(3, 2, 'delivered', '2026-03-03 10:00+01', '2026-03-03 15:00+01');

SELECT driver_id, COUNT(*) AS assigned_deliveries
FROM logistics_deliveries
GROUP BY driver_id
ORDER BY driver_id;

ROLLBACK;
