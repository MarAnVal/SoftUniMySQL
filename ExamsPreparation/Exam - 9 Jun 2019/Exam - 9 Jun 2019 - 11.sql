-- Create a stored procedure udp_clientinfo which accepts the following parameters: full_name
-- And extracts data about the client with the given full name.
-- Aside from the full_name, the procedure should extract the client's age, bank account number and balance.
-- The account’s salary should have "$" prefix.
DELIMITER $$
create PROCEDURE udp_clientinfo(client_full_name varchar(50))
begin
select 
cl.full_name full_name,
cl.age as age,
ba.account_number as account_number,
concat('$', ba.balance) as balance
from clients as cl
join bank_accounts as ba on ba.client_id = cl.id
where cl.full_name = client_full_name;
end$$
DELIMITER ;
call udp_clientinfo('Hunter Wesgate');
-- full_name 		age  account_number   balance
-- Hunter Wesgate	33 	 69666616-8		  $803355.32
