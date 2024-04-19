-- Create a user defined function with the name udf_client_bill(full_name VARCHAR(50))
--  that receives a customer’s full name and returns the total price of products he ordered;

DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
RETURNS DECIMAL(10,2)
BEGIN
DECLARE client_id INT;
SET client_id = (
select
id
from clients
where concat_ws(' ', first_name, last_name) = full_name
);
RETURN (
select sum(p.price)
from orders_clients as oc
join orders_products as op on oc.order_id = op.order_id
join products as p on p.id = op.product_id
where oc.client_id = client_id

);
END$$
DELIMITER ;