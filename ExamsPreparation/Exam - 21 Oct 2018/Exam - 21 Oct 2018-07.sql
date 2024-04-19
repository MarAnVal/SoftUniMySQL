SELECT 
    c.id, CONCAT_WS(' ', first_name, last_name) AS full_name
FROM
    colonists AS c
        JOIN
    travel_cards AS t ON c.id = t.colonist_id
WHERE
    t.job_during_journey = 'Pilot'
ORDER BY c.id ASC;