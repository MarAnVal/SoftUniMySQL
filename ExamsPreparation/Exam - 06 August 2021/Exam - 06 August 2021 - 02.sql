-- You will have to insert records of data into the games table, based on the teams table. 
-- For all teams with id between 1 and 9 (both inclusive), insert data in the games table with the following values:
-- name: the name of the team but reversed ( all letters must be lower case witout the starting character of the team's name
--  Example: Team name – Thiel -> leih)
-- rating – set it to be equal to the team's id
-- budget – set it to be equal to the leader's id multiplied by 1000
-- team_id – set it to be equal to the team's id

insert INTO games(`name`, rating, budget, team_id)
SELECT 
    LOWER(REVERSE(SUBSTRING(t.`name`, 2))) AS `name`,
    t.id AS rating,
    t.leader_id * 1000 AS budget,
    t.id AS team_id
FROM
    teams AS t
WHERE
    t.id BETWEEN 1 AND 9;


