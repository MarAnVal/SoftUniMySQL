SELECT 
    COUNT(c.id) as count
FROM
    colonists AS c
        JOIN
    travel_cards AS t ON c.id = t.colonist_id
        JOIN
    journeys AS j ON t.journey_id = j.id
WHERE
    j.purpose = 'Technical';