-- Extract from the database, the name the country and the number of movies created in this country.
-- The number of movies must be higher or equal to 7.

SELECT 
    c.`name` AS `name`, COUNT(m.id) AS movies_count
FROM
    countries AS c
        JOIN
    movies AS m ON c.id = m.country_id
GROUP BY c.id
HAVING COUNT(m.id) >= 7
ORDER BY c.`name` DESC;