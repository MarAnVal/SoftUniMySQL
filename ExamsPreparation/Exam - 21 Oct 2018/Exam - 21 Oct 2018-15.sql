-- 15
-- Create a user defined function with the name udf_count_colonists_by_destination_planet (planet_name VARCHAR (30))
-- that receives planet name and returns the count of all colonists sent to that planet.
DELIMITER $$
CREATE FUNCTION udf_count_colonists_by_destination_planet (planet_name VARCHAR (30))
RETURNS INT
BEGIN
RETURN(
SELECT 
    COUNT(c.id)
FROM
    colonists AS c
        JOIN
    travel_cards AS tc ON c.id = colonist_id
        JOIN
    journeys AS j ON j.id = tc.journey_id
        JOIN
    spaceports AS s ON s.id = j.destination_spaceport_id
        JOIN
    planets AS p ON p.id = planet_id
    WHERE p.`name` = planet_name);
END$$
DELIMITER ;
