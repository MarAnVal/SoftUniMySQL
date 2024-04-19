-- Create a user defined function with the name udf_stadium_players_count (stadium_name VARCHAR(30))
--  that receives a stadium’s name and returns the number of players that play home matches there.
DELIMITER $$
create function udf_stadium_players_count (stadium_name VARCHAR(30))
returns INT
BEGIN
return(
SELECT 
            COUNT(*)
        FROM
            players AS p
                JOIN
            teams AS t ON p.team_id = t.id
                JOIN
            stadiums AS s ON t.stadium_id = s.id
        WHERE s.`name` = stadium_name
);
END$$
DELIMITER ;

