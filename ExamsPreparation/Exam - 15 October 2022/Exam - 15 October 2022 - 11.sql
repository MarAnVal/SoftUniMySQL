-- Create a stored procedure udp_happy_hour( `type` (VARCHAR(50))
-- Extracts data about the products from the given type and reduces the prices by 20% 
-- of all products which have price higher or equal to 10.00 and are from the given type.

DELIMITER $$
CREATE PROCEDURE udp_happy_hour( p_type VARCHAR(50))
BEGIN

update products
set price = price * 0.8
where `type` = p_type and price >= 10;

END $$
DELIMITER ;

CALL udp_happy_hour ('Cognac');