SELECT 
    j.id AS id,
    p.`name` AS planet_name,
    s.`name` AS spaceport_name,
    j.purpose AS journey_purpose
FROM
    planets AS p
        JOIN
    spaceports AS s ON p.id = s.planet_id
        JOIN
    journeys AS j ON s.id = j.destination_spaceport_id
ORDER BY DATEDIFF(j.journey_end, j.journey_start) ASC
LIMIT 1;