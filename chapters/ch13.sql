SELECT city FROM customers WHERE city IS NOT NULL
UNION
SELECT city FROM suppliers WHERE city IS NOT NULL
ORDER BY city;

SELECT city FROM customers WHERE city IS NOT NULL
INTERSECT
SELECT city FROM suppliers WHERE city IS NOT NULL
ORDER BY city;

SELECT city FROM customers WHERE city IS NOT NULL
EXCEPT
SELECT city FROM suppliers WHERE city IS NOT NULL
ORDER BY city;
