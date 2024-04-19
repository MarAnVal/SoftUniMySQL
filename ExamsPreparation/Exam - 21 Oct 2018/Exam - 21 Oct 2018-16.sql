-- Create a user defined stored procedure with the name udp_modify_spaceship_light_speed_rate(spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
-- that receives a spaceship name and light speed increase value and increases spaceship light speed only if the given spaceship exists.
-- If the modifying is not successful rollback any changes
-- and throw an exception with error code ‘45000’ and message: “Spaceship you are trying to modify does not exists.” 
DELIMITER $$
CREATE PROCEDURE udp_modify_spaceship_light_speed_rate(spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
BEGIN
IF(select count(id) from spaceships where `name` = spaceship_name) > 0 then 
update spaceships
set light_speed_rate = light_speed_rate + light_speed_rate_increse
where `name` = spaceship_name;
else 
signal sqlstate '45000'
set Message_text = 'Spaceship you are trying to modify does not exists.';
rollback;
end if;
END$$
DELIMITER ;