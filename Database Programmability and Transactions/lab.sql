-- 1
DELIMITER $$
-- >
CREATE FUNCTION ufn_count_employees_by_town(`town_name` VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE count INT;
SET count := (
SELECT count(*)
FROM employees AS e
JOIN addresses AS a ON a.address_id = e.address_id
JOIN towns as t on t.town_id = a.town_id
WHERE t.`name` = `town_name`
);
RETURN count;
END 
-- <--
$$

DELIMITER ;

SELECT UFN_COUNT_EMPLOYEES_BY_TOWN('Sofia') AS count;


-- 2
-- usp_raise_salaries(department_name) to raise the salary of all employees in given department as parameter by 5%

DELIMITER //
-- >
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
DECLARE percent_rise DECIMAL(3, 2);
DECLARE department_id_change VARCHAR(50);
SET percent_rise := 1 + 0.05;
set department_id_change := (select DISTINCT d.department_id from departments as d where d.`name` = department_name);
IF(
(SELECT count(*) from employees as e where e.department_id = department_id_change) > 0
)
THEN
update employees e
set e.salary = e.salary * percent_rise where e.department_id = department_id_change;
ELSE
rollback;
END IF;
END
-- <--
//
DELIMITER ;
;
call usp_raise_salaries('Sales', @test);
select @test;

-- 3
DELIMITER \\
-- >
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
DECLARE rise_index DECIMAL (3, 2);
SET rise_index = 1 + 0.05;
IF(
(SELECT count(*) from employees as e where e.employee_id = id) = 1
)
THEN
UPDATE employees as e
SET e.salary = e.salary * rise_index;
ELSE
ROLLBACK;
END IF;
END \\ -- < -- bez \\

DELIMITER ;
;

-- 4
-- Create a table deleted_employees(employee_id PK, first_name,last_name,middle_name,job_title,deparment_id,salary) that will hold information
-- about fired(deleted) employees from the employees table.
-- Add a trigger to employees table that inserts the corresponding information in deleted_employees.
CREATE table deleted_employees(
employee_id int primary key AUTO_INCREMENT,
first_name VARCHAR(50),
last_name VARCHAR(50),
middle_name VARCHAR(50),
job_title VARCHAR(50),
department_id INT,
salary DECIMAL(19,4)
);

DELIMITER \\
create TRIGGER tr_after_delete_employ
AFTER DELETE
on employees
for each row
BEGIN
INSERT INTO deleted_employees(first_name, last_name, middle_name, job_title, department_id, salary)
VALUES (OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, salary);
END\\

DELIMITER ;