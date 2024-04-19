SELECT 
    p.`name` AS planet_name, `port`.`name` AS spaceport_name
FROM
    planets AS p
        JOIN
    spaceports AS `port` ON p.id = `port`.planet_id
        JOIN
    journeys AS j ON `port`.id = j.destination_spaceport_id
WHERE
    LOWER(j.purpose) = 'educational'
ORDER BY `port`.name DESC;