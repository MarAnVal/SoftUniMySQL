-- 1
SELECT 
    department_id, COUNT(id) AS `Number of employees`
FROM
    employees
GROUP BY department_id;

-- 2
SELECT 
    department_id,
    ROUND(AVG(salary), 2) AS `Number of employees`
FROM
    employees
GROUP BY department_id;

-- 3
SELECT 
    department_id, ROUND(MIN(salary), 2) AS `Min Salary`
FROM
    employees
GROUP BY department_id
HAVING `Min Salary` > 800;

-- 4
SELECT 
    COUNT(id)
FROM
    products
WHERE
    category_id = 2 AND price > 8;
    
-- 5
-- Category_id, Average Price, Cheapest Product, Most Expensive Product
SELECT 
    category_id,
    ROUND(AVG(price), 2) AS `Average Price`,
    ROUND(MIN(price), 2) AS `Cheapest Product`,
    ROUND(MAX(price), 2) AS `Most Expensive Product`
FROM
    products
GROUP BY category_id;