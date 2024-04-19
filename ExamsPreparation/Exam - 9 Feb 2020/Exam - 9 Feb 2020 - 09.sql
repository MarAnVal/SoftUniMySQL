-- And like everything else in this world, everything is ultimately about finances. 
-- Now you need to extract detailed information on the amount of all salaries given 
-- to football players by the criteria of the country in which they played.
-- If there are no players in a country, display NULL.  Order the results by 
-- total count of players in descending order, then by country name alphabetically.


SELECT 
    c.`name` AS `name`,
    COUNT(p.id) AS total_count_of_players,
    SUM(p.salary) AS total_sum_of_salaries
FROM
    players AS p
        JOIN
    teams AS tm ON p.team_id = tm.id
        JOIN
    stadiums AS s ON tm.stadium_id = s.id
        JOIN
    towns AS tn ON s.town_id = tn.id
        RIGHT JOIN
    countries AS c ON tn.country_id = c.id
GROUP BY c.`name`
ORDER BY total_count_of_players DESC , c.`name` ASC;
