-- Create a user defined function with the name udf_client_cards_count(name VARCHAR(30))
-- that receives a client's full name and returns the number of cards he has.
DELIMITER $$
create function udf_client_cards_count(`name` VARCHAR(30))
returns int 
deterministic
begin
return (SELECT 
    COUNT(cr.id)
FROM
    cards AS cr
        JOIN
    bank_accounts AS ba ON cr.bank_account_id = ba.id
        JOIN
    clients AS cl ON cl.id = ba.client_id    
    where cl.full_name = `name`);
end$$

DELIMITER ;

SELECT c.full_name, udf_client_cards_count('Baxy David') as `cards` FROM clients c
WHERE c.full_name = 'Baxy David';
-- full_name      cards
-- Baxy David        6

;