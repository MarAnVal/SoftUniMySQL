-- Extract from the database, the top 5 employees, in terms of clients assigned to them.
-- Order the results descending by count of clients, and ascending by employee id.

SELECT 
    CONCAT_WS(' ', e.first_name, e.last_name) AS `name`,
    e.started_on,
    COUNT(client_id) AS count_of_clients
FROM
    employees AS e
        JOIN
    employees_clients AS ec ON e.id = ec.employee_id
GROUP BY e.id
ORDER BY COUNT(client_id) DESC , e.id ASC
LIMIT 5;