-- Extract from the database the fastest spaceship and its destination spaceport name. In other words, the ship with the highest light speed rate.

-- Required Columns
-- spaceship_name
-- spaceport_name
SELECT 
    ship.`name` AS spaceship_name,
    `port`.`name` AS spaceport_name
FROM
    spaceships AS ship
        JOIN
    journeys AS j ON ship.id = j.spaceship_id
        JOIN
    spaceports AS `port` ON j.destination_spaceport_id = `port`.id
WHERE
    light_speed_rate = (SELECT 
            MAX(light_speed_rate)
        FROM
            spaceships);