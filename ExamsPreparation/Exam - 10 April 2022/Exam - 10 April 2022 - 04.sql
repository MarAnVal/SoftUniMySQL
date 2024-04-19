-- Delete all countries that don’t have movies.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM countries 
WHERE
    id IN (SELECT 
        *
    FROM
        (SELECT 
            c.id
        FROM
            countries AS c
        LEFT JOIN movies AS m ON c.id = m.country_id
        
        WHERE
            m.id IS NULL) AS a);
