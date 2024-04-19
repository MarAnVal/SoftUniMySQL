-- Create a stored procedure udp_courses_by_address (address_name varchar (100))
-- Extract data about the addresses with the given address_name. 
-- The needed output data is the 
-- name of the address, 
-- full name of the client, 
-- level of bill (depends of course bill – Low – lower than 20(inclusive), Medium – lower than 30(inclusive), and High), 
-- make and condition of the car and the name of the category.
--  Order addresses by make, then by client’s full name.

DELIMITER $$
create procedure udp_courses_by_address (address_name varchar (100))
begin
DECLARE address_id int(11);
SET address_id = (select a.id from addresses as a where a.`name` = address_name);
SELECT 
    address_name,
    cl.full_name AS full_name,
    (CASE
        WHEN cr.bill <= 20 THEN 'Low'
        WHEN cr.bill > 30 THEN 'High'
        ELSE 'Medium'
    END) AS level_of_bill,
    c.make AS make,
    c.`condition` AS `condition`,
    ct.`name` AS cat_name
FROM
    clients AS cl
        JOIN
    courses AS cr ON cl.id = cr.client_id
        JOIN
    cars AS c ON c.id = cr.car_id
        JOIN
    categories AS ct ON ct.id = c.category_id
WHERE
    cr.from_address_id = address_id
ORDER BY c.make , cl.full_name;

end$$
DELIMITER ;

CALL udp_courses_by_address('700 Monterey Avenue');

CALL udp_courses_by_address('66 Thompson Drive');