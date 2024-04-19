-- Now, we need to find all interesting upcoming games.
-- Extract from the database all games that are being released in the year 2022. Also, the month must be even.
-- We need only the first game sequel (ends with '…2').
--  We need the information of the game name, the game release date, a short summary (only the first 10 characters + '…') and the name of the team.
-- At last, a column ‘Quarters’ depends on the month of the release date:
-- January, February, and March (Q1)
-- April, May, and June (Q2)
-- July, August, and September (Q3)
-- October, November, and December (Q4)
-- Order by Quarters.

SELECT 
    g.`name`,
    g.release_date,
    (CONCAT(SUBSTRING(g.`description`, 1, 10), '...')) AS summary,
    (CONCAT('Q', CEIL(MONTH(g.release_date) / 3))) AS `quarter`,
    (SELECT 
            t.`name`
        FROM
            teams AS t
        WHERE
            t.id = g.team_id) AS team_name
FROM
    games AS g
WHERE
    g.`name` LIKE '%2'
        AND YEAR(g.release_date) = 2022
        AND MONTH(g.release_date) % 2 = 0
ORDER BY `quarter`;