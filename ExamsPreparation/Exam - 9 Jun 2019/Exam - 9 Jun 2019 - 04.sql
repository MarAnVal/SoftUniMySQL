-- R.U.K. Bank is a sophisticated network. As such, it cannot allow procrastination and lazy behavior. 
-- Delete all employees which do not have any clients. 
DELETE FROM employees 
WHERE
    id IN (SELECT 
        b.id
    FROM
        (SELECT 
            e.id AS id, COUNT(client_id) AS count
        FROM
            employees AS e
        LEFT JOIN employees_clients AS ec ON e.id = ec.employee_id
        GROUP BY e.id) AS b
    
    WHERE
        b.count < 1);