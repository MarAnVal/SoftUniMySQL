-- Now, we need a more detailed information about categories – count of game, average budget and max rating.
-- Select all categories names, count of the games from each category, 
-- the average budget (rounded to the second digit after the decimal point) of all games from the current category
-- and the max rating of games from a category.
-- Order the result by count of games in descending order, then by the name of the category alphabetically. 
-- Skip categories with max rating lower than 9.5(exclusive).

SELECT 
    (SELECT 
            `name`
        FROM
            categories AS ct
        WHERE
            ct.id = gc.category_id) AS `name`,
    COUNT(g.id) AS games_count,
    ROUND(AVG(g.budget), 2) AS avg_budget,
    MAX(g.rating) AS max_rating
FROM
    games AS g
        JOIN
    games_categories AS gc ON g.id = gc.game_id
GROUP BY gc.category_id
HAVING MAX(g.rating) >= 9.5
order by games_count desc, `name`;