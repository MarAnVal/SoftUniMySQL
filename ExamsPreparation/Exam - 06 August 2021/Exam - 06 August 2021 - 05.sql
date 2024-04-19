-- Extract from the SoftUni Game Dev Branch (sgd) database, info about all the employees. 
-- Order the results by the employee's salary, then by their id.
SELECT 
    first_name, last_name, age, salary, happiness_level
FROM
    employees
    order by salary, id;