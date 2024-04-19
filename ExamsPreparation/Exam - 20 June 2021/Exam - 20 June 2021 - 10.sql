-- Create a user defined function with the name udf_courses_by_client (phone_num VARCHAR (20))
--  that receives a client’s phone number and returns the number of courses that clients have in database.
DELIMITER $$
create FUNCTION udf_courses_by_client(phone_num VARCHAR (20))
RETURNS INT
begin
RETURN (
select
count(cr.id)
from courses as cr
where cr.client_id = (
select cl.id from clients as cl where cl.phone_number = phone_num
)
);
end$$
DELIMITER ;

SELECT udf_courses_by_client ('(803) 6386812') as `count`; -- result 5