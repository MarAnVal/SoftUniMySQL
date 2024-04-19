-- Create a stored procedure udp_find_playmaker(min_dribble_points int(11), team_name varchar(45))
--  And extracts data about the players with the given skill stats (more than min_dribble_points), 
--  played for given team (team_name) and have more than average speed for all players. 
-- Order players by speed descending. Select only the best one.
-- Show all needed info for this player: full_name, age, salary, dribbling, speed, team name.
DELIMITER $$
create PROCEDURE udp_find_playmaker(min_dribble_points int(11), team_name varchar(45))
begin
select 
a.full_name as full_name,
a.age as age,
a.salary as salary,
a.dribbling as dribbling,
a.speed as speed,
a.team_name as team_name
from 
(SELECT 
    CONCAT_WS(' ', p.first_name, p.last_name) as full_name,
    p.age as age,
    p.salary as salary,
    sk.dribbling as dribbling,
    sk.speed as speed,
    t.`name` as team_name
FROM
    skills_data AS sk
        JOIN
    players AS p ON p.skills_data_id = sk.id
        JOIN
    teams AS t ON p.team_id = t.id
WHERE
    t.`name` = team_name
        AND sk.dribbling > min_dribble_points) as a
where speed > (select avg(speed) from skills_data)
ORDER BY speed DESC limit 1;
end$$
DELIMITER ;

