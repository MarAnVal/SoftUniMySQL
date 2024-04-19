SELECT DISTINCT
    `ship`.`name` AS `name`,
    `ship`.manufacturer AS manufacturer
FROM
    spaceships `ship`
        JOIN
    journeys AS j ON j.spaceship_id = `ship`.id
        JOIN
    travel_cards AS t ON t.journey_id = j.id
        JOIN
    colonists AS c ON t.colonist_id = c.id
WHERE
    c.birth_date > '1989-01-01'
        AND t.job_during_journey = 'Pilot'
ORDER BY `name` ASC;