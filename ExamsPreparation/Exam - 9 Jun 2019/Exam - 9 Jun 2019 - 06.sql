-- Extract from the database, all of the employees, which have salary greater than or equal to 100000 
-- and have started later than or equal to the 1st of January - 2018. 
-- The salary should have a "$" as a prefix.

SELECT 
    id,
    CONCAT_WS(' ', first_name, last_name) AS full_name,
    concat('$',salary) as salary,
    started_on
FROM
    employees
WHERE
    YEAR(started_on) >= 2018
        AND salary > 100000
ORDER BY salary DESC , id;