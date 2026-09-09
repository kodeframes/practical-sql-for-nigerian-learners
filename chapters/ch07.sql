SELECT
    order_item_id,
    quantity * unit_price AS gross_value,
    quantity * unit_price - discount_amount AS net_line_value
FROM order_items
ORDER BY order_item_id;

SELECT
    customer_id,
    customer_name,
    CASE
        WHEN email IS NULL THEN 'missing_email'
        ELSE 'email_recorded'
    END AS email_status,
    COALESCE(phone, '[no phone recorded]') AS phone_display
FROM customers
ORDER BY customer_id;
