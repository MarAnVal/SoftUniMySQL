-- The managers always want to know how the business goes. Now, they want from us to show all store names, 
-- but for security, the name must be in the reversed order.
-- Select the name of stores (in reverse order). 
-- After that, the full_address in format: {town name in upper case}-{address name}.
-- The next info is the count of employees, that work in the store.
-- Filter only the stores that have a one or more employees.


SELECT 
    REVERSE(s.`name`) AS reversed_name,
    CONCAT_WS('-', upper(t.`name`), a.`name`) AS full_address,
    COUNT(e.id) AS employees_count
FROM
    employees AS e
        JOIN
    stores AS s ON s.id = e.store_id
        JOIN
    addresses AS a ON a.id = s.address_id
        JOIN
    towns AS t ON t.id = a.town_id
GROUP BY s.`name`
ORDER BY full_address ASC;