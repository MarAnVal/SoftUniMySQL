-- Create a user defined function with the name udf_top_paid_employee_by_store(store_name VARCHAR(50)) 
-- that receives a store name and returns the full name of top paid employee. 
-- Full info must be in format:  	{first_name} {middle_name}. {last_name} works in store for {years of experience} years
-- The years of experience is the difference when they were hired and 2020-10-18
DELIMITER $$
create FUNCTION udf_top_paid_employee_by_store(store_name VARCHAR(50))
returns varchar(100)
begin
return(
select
concat(
concat_ws(' ', e.first_name, concat(e.middle_name, '.'), e.last_name),
' works in store for ',
floor(abs(datediff(e.hire_date, '2020-10-18')/365)),
' years'
) as full_info
from employees as e 
join stores as s on s.id = e.store_id where s.`name` = store_name
order by e.salary desc limit 1);
end$$
DELIMITER ;

SELECT udf_top_paid_employee_by_store('Stronghold') as 'full_info';
SELECT udf_top_paid_employee_by_store('Keylex') as 'full_info';


