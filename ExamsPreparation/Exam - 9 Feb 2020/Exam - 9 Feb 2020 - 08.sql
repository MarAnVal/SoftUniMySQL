-- Extract from the database, the fastest player (having max speed), in terms of towns where their team played.
-- Order players by speed descending, then by town name.
-- Skip players that played in team ‘Devify’

SELECT 
    MAX(sk.speed) AS max_speed, tn.`name` AS town_name
FROM
    players AS p
        RIGHT JOIN
    (SELECT 
        *
    FROM
        teams AS a
    WHERE
        a.`name` <> 'Devify') AS t ON t.id = p.team_id
        LEFT JOIN
    skills_data AS sk ON p.skills_data_id = sk.id
        LEFT JOIN
    stadiums AS s ON t.stadium_id = s.id
        LEFT JOIN
    towns AS tn ON tn.id = s.town_id
GROUP BY tn.`name`
ORDER BY max_speed DESC , town_name;
