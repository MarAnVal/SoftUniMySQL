-- Create a user defined function with the name udf_game_info_by_name (game_name VARCHAR (20))
--  that receives a game's name and returns the basic information as a text sentence.
-- Example
-- The "game_name" is developed by a "team_name" in an office 
-- with an address "address_text"

DELIMITER $$
create function udf_game_info_by_name (game_name VARCHAR (20))
returns text
begin
return(
select
concat('The ', g.`name`,' is developed by a ', t.`name`,' in an office with an address ', a.`name`)
from
games as g
left join teams as t on t.id = g.team_id
left join offices as o on o.id = t.office_id
left join addresses as a on a.id = o.address_id
where 
g.`name` = game_name
);
end $$
DELIMITER ;