PREPARE customer_by_state(text) AS
SELECT customer_id, customer_name, state
FROM customers
WHERE state = $1
ORDER BY customer_id;

EXECUTE customer_by_state('Lagos');
DEALLOCATE customer_by_state;
