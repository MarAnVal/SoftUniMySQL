-- Update all clients which have the same id as the employee they are appointed to.
-- Set their employee_id with the employee with the lowest count of clients.
-- If there are 2 such employees with equal count of clients, take the one with the lowest id.

UPDATE employees_clients 
SET 
    employee_id = (select * from(SELECT 
            a.employee_id
        FROM
            employees_clients as a
        GROUP BY a.employee_id
        ORDER BY COUNT(a.client_id) ASC , a.employee_id ASC
        LIMIT 1) as b)
WHERE
    employee_id = client_id;