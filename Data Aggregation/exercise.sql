-- 1
SELECT 
    COUNT(*) as `count`
FROM
    wizzard_deposits;
    
-- 2
SELECT 
    MAX(magic_wand_size) AS `longest_magic_wand`
FROM
    wizzard_deposits;

-- 3
SELECT 
    deposit_group, MAX(magic_wand_size) AS `longest_magic_wand`
FROM
    wizzard_deposits
GROUP BY deposit_group
ORDER BY `longest_magic_wand` ASC , `deposit_group` ASC;

-- 4
SELECT 
    deposit_group
FROM
    wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;

-- 5
SELECT 
    deposit_group, SUM(deposit_amount) AS total_sum
FROM
    wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum ASC;

-- 6
SELECT 
    deposit_group, SUM(deposit_amount) AS total_sum
FROM
    wizzard_deposits
WHERE
    magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group ASC;

-- 7
SELECT 
    deposit_group, SUM(deposit_amount) AS total_sum
FROM
    wizzard_deposits
WHERE
    magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING total_sum < 150000
ORDER BY total_sum DESC;

-- 8
SELECT 
    deposit_group, magic_wand_creator, MIN(deposit_charge)
FROM
    wizzard_deposits
GROUP BY deposit_group , magic_wand_creator
ORDER BY magic_wand_creator , deposit_group;

-- 9
SELECT 
    CASE
        WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
    END AS `age_group`,
    COUNT(*) AS `wizard_count`
FROM
    wizzard_deposits
GROUP BY `age_group`
ORDER BY `age_group`;

-- 10
SELECT 
    LEFT(`first_name`, 1) AS `first_letter`
FROM
    wizzard_deposits
WHERE
    deposit_group = 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;

-- 11
SELECT 
    deposit_group,
    is_deposit_expired,
    AVG(deposit_interest) AS `average_interest`
FROM
    wizzard_deposits
WHERE
    deposit_start_date >= '1985-01-01'
GROUP BY deposit_group , is_deposit_expired
ORDER BY deposit_group DESC , is_deposit_expired ASC;

-- 12
SELECT 
    department_id, MIN(salary) AS `minimum_salary`
FROM
    employees
WHERE
    department_id IN (2 , 5, 7)
        AND hire_date > '2000-01-01'
GROUP BY department_id
ORDER BY department_id;

-- 13
SELECT 
    department_id,
    AVG(IF(department_id = 1,
        salary + 5000,
        salary)) AS `avg_salary`
FROM
    employees
WHERE
    salary > 30000 AND manager_id <> 42
GROUP BY department_id
ORDER BY department_id ASC;

-- 14
SELECT 
    department_id, MAX(salary) AS `max_salary`
FROM
    employees
GROUP BY department_id
HAVING max_salary NOT BETWEEN 30000 AND 70000
ORDER BY department_id ASC;

-- 15
SELECT 
    COUNT(*)
FROM
    employees
WHERE
    manager_id IS NULL;
    
-- 16
SELECT 
    department_id,
    (SELECT DISTINCT
            salary
        FROM
            employees AS e1
        WHERE
            e1.department_id = employees.department_id
        ORDER BY salary DESC
        LIMIT 1 OFFSET 2) AS `third_highest_salary`
FROM
    employees
GROUP BY department_id
HAVING `third_highest_salary` IS NOT NULL
ORDER BY department_id;

-- 17
SELECT 
    first_name, last_name, department_id
FROM
    employees AS e1
WHERE
    e1.salary > (SELECT 
            AVG(salary)
        FROM
            employees AS e2
        WHERE
            e1.department_id = e2.department_id
        GROUP BY department_id)
ORDER BY department_id , employee_id
LIMIT 10;

-- 18
SELECT 
    department_id, SUM(salary) AS `total_salary`
FROM
    employees
GROUP BY department_id
ORDER BY department_id;