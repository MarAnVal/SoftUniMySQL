-- 1
SELECT 
    e.employee_id AS employee_id,
    e.job_title AS job_title,
    a.address_id AS address_id,
    a.address_text AS address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON a.address_id = e.address_id
ORDER BY address_id ASC
LIMIT 5;

-- 2
SELECT 
    e.first_name AS first_name,
    e.last_name AS last_name,
    t.`name` AS town,
    a.address_text AS address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON a.address_id = e.address_id
        JOIN
    towns AS t ON t.town_id = a.town_id
ORDER BY first_name ASC , last_name
LIMIT 5;

-- 3
SELECT 
    e.employee_id AS employee_id,
    e.first_name AS first_name,
    e.last_name AS last_name,
    d.`name` AS department_name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    d.`name` = 'Sales'
ORDER BY employee_id DESC;

-- 4
SELECT 
    e.employee_id AS employee_id,
    e.first_name AS first_name,
    e.salary AS salary,
    d.`name` AS department_name
FROM
    employees AS e
        JOIN
    departments as d ON e.department_id = d.department_id
WHERE
    e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

-- 5
SELECT DISTINCT
    e.employee_id AS employee_id, e.first_name AS first_name
FROM
    employees AS e
        LEFT JOIN
    employees_projects AS p ON e.employee_id = p.employee_id
WHERE
    p.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

-- 6
SELECT 
    e.first_name AS first_name,
    e.last_name AS last_name,
    e.hire_date AS hire_date,
    d.`name` AS dept_name
FROM
    employees AS e
        JOIN
    departments AS d ON d.department_id = e.department_id
WHERE
    e.hire_date > '1999-01-01'
        AND d.`name` IN ('Sales' , 'Finance')
ORDER BY e.hire_date ASC;

-- 7
SELECT 
    e.employee_id AS employee_id,
    e.first_name AS first_name,
    p.`name` AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON ep.project_id = p.project_id
WHERE
    DATE(p.start_date) > DATE('2002-08-13')
        AND p.end_date IS NULL
ORDER BY first_name ASC , project_name ASC
LIMIT 5;

-- 8
SELECT 
    e.employee_id AS employee_id,
    e.first_name AS first_name,
    p.`name` AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        AND e.employee_id = 24
        LEFT JOIN
    projects AS p ON ep.project_id = p.project_id
        AND YEAR(p.start_date) < '2005'
ORDER BY project_name ASC;

-- 9
SELECT 
    e.employee_id AS employee_id,
    e.first_name AS first_name,
    m.manager_id AS manager_id,
    m.manager_name AS manager_name
FROM
    (SELECT 
        employee_id, first_name, manager_id
    FROM
        employees
    WHERE
        manager_id IN (3 , 7)) AS e
        JOIN
    (SELECT 
        employee_id AS manager_id, first_name AS manager_name
    FROM
        employees) AS m ON e.manager_id = m.manager_id
ORDER BY e.first_name ASC;

-- 10
SELECT 
    e.employee_id,
    e.employee_name AS employee_name,
    CONCAT_WS(' ', m.first_name, m.last_name) AS manager_name,
    d.`name` AS department_name
FROM
    (SELECT 
        employee_id,
            CONCAT_WS(' ', first_name, last_name) AS employee_name,
            manager_id,
            department_id
    FROM
        employees
    WHERE
        manager_id IS NOT NULL
    ORDER BY employee_id
    LIMIT 5) AS e
        LEFT JOIN
    employees AS m ON e.manager_id = m.employee_id
        LEFT JOIN
    departments AS d ON e.department_id = d.department_id;
    
-- 11
SELECT 
    MIN(a.salary) AS salary
FROM
    (SELECT 
        AVG(b.salary) AS salary, department_id
    FROM
        employees as b
    GROUP BY b.department_id) as a;

-- 12
SELECT 
    c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    (SELECT 
        *
    FROM
        countries
    WHERE
        country_code = 'BG') AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON mc.mountain_id = m.id
        JOIN
    (SELECT 
        *
    FROM
        peaks
    WHERE
        elevation > 2835) AS p ON p.mountain_id = m.id
ORDER BY p.elevation DESC;

-- 13
SELECT 
    c.country_code AS country_name,
    COUNT(m.mountain_range) AS mountain_range
FROM
    mountains AS m
        JOIN
    mountains_countries AS mc ON m.id = mc.mountain_id
        RIGHT JOIN
    (SELECT 
        *
    FROM
        countries AS a
    WHERE
        a.country_name IN ('United States' , 'Russia', 'Bulgaria')) AS c ON mc.country_code = c.country_code
GROUP BY c.country_code
ORDER BY mountain_range DESC;

-- 14
SELECT 
    c.country_name, r.river_name
FROM
    (SELECT 
        a.country_code, a.country_name, continent_name
    FROM
        countries AS a
    JOIN continents AS b ON a.continent_code = b.continent_code
        AND continent_name = 'Africa') AS c
        LEFT JOIN
    countries_rivers AS cr ON c.country_code = cr.country_code
        LEFT JOIN
    rivers AS r ON cr.river_id = r.id
ORDER BY c.country_name ASC
LIMIT 5;

-- 15
SELECT
    c1.continent_code AS continent_code,
    c1.currency_code AS currency_code,
    COUNT(*) AS currency_usage
FROM
    countries AS c1
GROUP BY c1.continent_code , c1.currency_code
HAVING currency_usage > 1
    AND currency_usage = (SELECT 
        COUNT(*) count_of_currencies
    FROM
        countries AS c2
    WHERE
        c1.continent_code = c2.continent_code
    GROUP BY c2.currency_code
    ORDER BY COUNT(*) DESC
    LIMIT 1)
ORDER BY c1.continent_code , c1.currency_code;

-- 16
SELECT 
    COUNT(*) AS country_count
FROM
    countries AS c
        LEFT JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
WHERE
    mountain_id IS NULL;

-- 17
SELECT 
    country_name,
    (SELECT 
            p.elevation
        FROM
            peaks AS p
                JOIN
            mountains_countries AS mc ON p.mountain_id = mc.mountain_id
        WHERE
            mc.country_code = c.country_code
        ORDER BY p.elevation DESC
        LIMIT 1) AS highest_peak_elevation,
    (SELECT 
            r.length
        FROM
            rivers AS r
                JOIN
            countries_rivers AS cr ON r.id = cr.river_id
        WHERE
            cr.country_code = c.country_code
        ORDER BY r.length DESC
        LIMIT 1) AS longest_river_length
FROM
    countries AS c
ORDER BY highest_peak_elevation DESC , longest_river_length DESC , country_name ASC
LIMIT 5;