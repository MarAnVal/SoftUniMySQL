-- Extract from the database all of the teams and the count of the players that they have.
-- Order the results descending by count of players, then by fan_base descending. 
SELECT 
    t.`name` AS team_name,
    t.established AS established,
    t.fan_base AS fan_base,
    COUNT(p.id) AS count_of_players
FROM
    teams AS t
        LEFT JOIN
    players AS p ON t.id = p.team_id
GROUP BY t.id
ORDER BY count_of_players DESC , fan_base DESC;