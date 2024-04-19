SELECT 
    result.planet_name AS planet_name,
    COUNT(planet_name) AS journeys_count
FROM
    (SELECT 
        p.`name` AS planet_name
    FROM
        planets AS p
    JOIN spaceports AS s ON p.id = s.planet_id
    JOIN journeys AS j ON s.id = j.destination_spaceport_id) AS result
GROUP BY result.planet_name
ORDER BY journeys_count DESC , planet_name ASC;