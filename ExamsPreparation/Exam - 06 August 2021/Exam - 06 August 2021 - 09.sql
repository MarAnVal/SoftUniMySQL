-- Our managers want to monitor all games that don’t have a release date nor a category. 
-- They want us to create a query, which shows the main information about the games. 
-- The information that they need is the name of the game, the name of the team, the name of the address and if the budget is less than 50000. 
-- If it is, we need to display 'Normal budget'. If it doesn’t - 'Insufficient budget'. 
-- Finally, we should order the result by the name of the game.

SELECT 
    g.`name` AS `name`,
    (CASE
        WHEN g.budget < 50000 THEN 'Normal budget'
        ELSE 'Insufficient budget'
    END) AS budget_level,
    t.`name` AS team_name,
    a.`name` AS address_name
FROM
    games AS g
        JOIN
    teams AS t ON t.id = g.team_id
        JOIN
    offices AS o ON o.id = t.office_id
        JOIN
    addresses AS a ON a.id = o.address_id
WHERE
    g.id NOT IN (SELECT 
            gc.game_id
        FROM
            games_categories AS gc)
        AND g.release_date IS NULL
ORDER BY g.`name`;