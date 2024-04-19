SELECT 
    t.job_during_journey AS job_name
FROM
    travel_cards AS t
        JOIN
    journeys AS j ON j.id = t.journey_id
WHERE
    j.id = (SELECT 
            id
        FROM
            journeys
        ORDER BY DATEDIFF(journey_end, journey_start) DESC
        LIMIT 1)
GROUP BY t.job_during_journey
ORDER BY COUNT(t.job_during_journey)
LIMIT 1;

