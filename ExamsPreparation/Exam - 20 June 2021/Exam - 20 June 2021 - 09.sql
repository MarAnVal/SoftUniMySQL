-- The headquarters want us to make a query that shows the complete information about all courses in the database. 
-- The information that they need is the address, if the course is made in the Day (between 6 and 20(inclusive both)) 
-- or in the Night (between 21 and 5(inclusive both)),
-- the bill of the course, the full name of the client, the car maker, the model and the name of the category.
-- Order the results by course id.


select
(SELECT a.`name` from addresses as a where a.id = cr.from_address_id)as `name`,
(case when hour(cr.`start`) >= 6 and hour(cr.`start`) <= 20 then 'Day'
else 'Night'
end) as day_time,
cr.bill as bill,
(select cl.full_name from clients as cl where cl.id = cr.client_id) as full_name,
(select c1.make from cars as c1 where c1.id = cr.car_id) as make,
(select c2.model from cars as c2 where c2.id = cr.car_id) as model,
(select ct.`name` from categories as ct join cars as c3 on c3.category_id = ct.id where c3.id = cr.car_id) as category_name
from courses as cr
order by cr.id asc;