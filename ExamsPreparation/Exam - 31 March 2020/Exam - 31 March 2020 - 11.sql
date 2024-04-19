-- Create a stored procedure udp_modify_user which accepts the following parameters: address, town 
-- udp_modify_user (address VARCHAR(30), town VARCHAR(30)) 
-- that receives an address and town and increase the age of the user by 10 years only if the given user exists. 
-- Show all needed info for this user: username, email, gender, age and job_title.

DELIMITER $$
create PROCEDURE udp_modify_user (address VARCHAR(30), town VARCHAR(30)) 
begin 
DECLARE user_id INT;
SET user_id = (SELECT 
    u.id
FROM
    users AS u
        JOIN
    addresses AS a ON u.id = a.user_id
WHERE
    a.town = town AND a.address = address);
UPDATE users 
SET 
    age = age + 10
WHERE
    id = user_id AND user_id IS NOT NULL;
END$$
DELIMITER ;



