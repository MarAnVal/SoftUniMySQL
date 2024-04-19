-- One of the coaches wants to know more about all the young players (under age of 23) 
-- who can strengthen his team in the offensive (played on position ‘A’). 
-- As he is not paying a transfer amount, he is looking only for those who have 
-- not signed a contract so far (haven’t hire_date) and have strength of more than 50. 
-- Order the results ascending by salary, then by age.

SELECT 
    p.id AS id,
    CONCAT_WS(' ', p.first_name, p.last_name) AS full_name,
    p.age AS age,
    p.position AS position,
    p.hire_date AS hire_date
FROM
    players AS p
        JOIN
    skills_data AS sk ON sk.id = p.skills_data_id
WHERE
    position = 'A' AND hire_date IS NULL
        AND age < 23
        AND sk.strength > 50
ORDER BY salary ASC , age ASC;