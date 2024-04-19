-- 1
-- Create procedure usp_get_employees_salary_above_35000 ()

-- that returns all employees' first and last names for whose salary is above 35000.
-- The result should be sorted by first_name then by last_name alphabetically, and id ascending
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000 ()
BEGIN
SELECT 
    e.first_name, e.last_name
FROM
    employees AS e
WHERE
    e.salary > 35000
ORDER BY e.first_name ASC , e.last_name ASC , employee_id ASC;
END$$
DELIMITER ;

call usp_get_employees_salary_above_35000;

-- 2
-- Create stored procedure usp_get_employees_salary_above that accept a decimal number (with precision, 4 digits after the decimal point) as parameter
-- Return all employee's first and last names whose salary is above or equal to the given number
-- The result should be sorted by first_name then by last_name alphabetically and id ascending
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above (salary_above_or_equal_to DECIMAL(19,4))
BEGIN
SELECT 
    e.first_name, e.last_name
FROM
    employees AS e
WHERE
    e.salary >= salary_above_or_equal_to
ORDER BY e.first_name ASC , e.last_name ASC , employee_id ASC;
END$$
DELIMITER ;

-- 3
-- Write a stored procedure usp_get_towns_starting_with that accept string as parameter 
-- Returns all town names starting with that string
-- The result should be sorted by town_name alphabetically
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (start_with VARCHAR(50))
BEGIN
DECLARE needed_chars INT;
SET needed_chars = char_length(start_with);
SELECT 
    t.`name`
FROM
    towns AS t
WHERE
    start_with = SUBSTRING(t.`name`, 1, needed_chars)
ORDER BY t.`name` ASC;
END$$
DELIMITER ;

-- 4
-- Write a stored procedure usp_get_employees_from_town that accepts town_name as parameter
-- Return the employees' first and last name that live in the given town
-- The result should be sorted by first_name then by last_name alphabetically and id ascending.
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
DECLARE needed_town_id INT;
SET needed_town_id := (SELECT town_id FROM towns as t WHERE t.`name` = town_name);
SELECT 
    first_name, last_name
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
WHERE
    a.town_id = needed_town_id
ORDER BY first_name ASC , last_name ASC , employee_id ASC;
END$$
DELIMITER ;

-- 5
-- Write a function ufn_get_salary_level that receives salary of an employee and returns the level of the salary.
-- • If salary is < 30000 return "Low"
-- • If salary is between 30000 and 50000 (inclusive) return "Average"
-- • If salary is > 50000 return "High"
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(checked_salary DECIMAL(19,4))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
RETURN (
CASE 
WHEN (checked_salary < 30000) THEN  'Low'
WHEN (checked_salary > 50000) THEN  'High'
ELSE 'Average'
END);
END $$
DELIMITER ; 

-- 6
-- Write a stored procedure usp_get_employees_by_salary_level that receive as parameter level of salary (low, average or high) 
-- RETURN the names of all employees that have given level of salary.
-- The result should be sorted by first_name then by last_name both in descending order.
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_lvl VARCHAR(50))
BEGIN
set salary_lvl := lower(salary_lvl);
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    salary_lvl = (CASE
        WHEN (salary < 30000) THEN 'low'
        WHEN (salary > 50000) THEN 'high'
        ELSE 'average'
    END)
ORDER BY first_name DESC , last_name DESC;
END$$

DELIMITER ;
call usp_get_employees_by_salary_level('high');

-- 7
-- Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50)) 
-- Returns 1 or 0 depending on that if the word is a comprised of the given set of letters. 
DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
BEGIN
DECLARE regex VARCHAR(55);
SET regex := CONCAT('^[', set_of_letters, ']+$');
RETURN word REGEXP(regex);
END $$
DELIMITER ;

-- 8
-- Write a stored procedure usp_get_holders_full_name that selects the full names of all people. 
-- The result should be sorted by full_name alphabetically and id ascending
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
SELECT 
CONCAT_WS(' ', first_name, last_name) as full_name
from account_holders
order by full_name asc, id asc;
END $$

DELIMITER ;

-- 9
-- create a stored procedure usp_get_holders_with_balance_higher_than that accepts a number as a parameter
-- Returns all people who have more money in total of all their accounts than the supplied number
-- The result should be sorted by account_holders.id ascending
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(needed_balance decimal(65,4))
BEGIN
SELECT ac.first_name, ac.last_name
from account_holders as ac 
join accounts as a on ac.id = a.account_holder_id 
group by ac.id
HAVING sum(a.balance) > needed_balance
order by ac.id asc;
END $$
DELIMITER ;

call usp_get_holders_with_balance_higher_than(7000);

-- 10
-- create a function ufn_calculate_future_value that accepts as parameters – 
-- sum (with precision, 4 digits after the decimal point), yearly interest rate (double) and number of years(int)
--  It should calculate and return the future value of the initial sum
--  The result from the function must be decimal, with percision 4. 
-- I – Initial sum
-- R – Yearly interest rate
-- T – Number of years
-- FV = Ix((1+R)powerT)

CREATE FUNCTION ufn_calculate_future_value(initial_sum DECIMAL(19, 4), yearly_interest_rate DECIMAL(19,4), number_of_years INT)
RETURNS DECIMAL(19,4)
RETURN(initial_sum*(power((1+yearly_interest_rate), number_of_years)));

select ufn_calculate_future_value(1000, 0.5, 5);

-- 11
-- create a stored procedure usp_calculate_future_value_for_account that accepts as parameters – id of account and interest rate.
-- The procedure uses the function from the previous problem to give an interest to a person's account for 5 years, along with information 
-- about his/her account id, first name, last name and current balance as it is shown in the example below. 
-- It should take the account_id and the interest_rate as parameters. 
-- Interest rate should have precision up to 0.0001, same as the calculated balance after 5 years. Be extremely careful to achieve the desired precision!

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(client_id INT, yearly_interest_rate DECIMAL(19,4))
BEGIN
DECLARE number_of_years INT;
SET number_of_years := 5;
SELECT
a.id as account_id,
ah.first_name as first_name,
ah.last_name as last_name,
a.balance as current_balance,
ufn_calculate_future_value(a.balance, yearly_interest_rate, number_of_years) as balance_in_5_years
from accounts as a
join account_holders as ah on ah.id = a.account_holder_id 
where a.id = client_id;
END $$
DELIMITER ;

call usp_calculate_future_value_for_account(1, 0.1);

-- 12
-- Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions.
-- Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point. 
-- The procedure should produce exact results working with the specified precision
DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
IF (SELECT count(id) from accounts where id = account_id) <> 1  or (money_amount <= 0)  THEN ROLLBACK;
 ELSE
UPDATE accounts
SET balance = balance + money_amount
where id = account_id;
END IF;
END $$
DELIMITER ;

-- 13
-- Add stored procedures usp_withdraw_money(account_id, money_amount) that operate in transactions.
-- Make sure to guarantee withdraw is done only when balance is enough and money_amount is valid positive number. 
-- Work with precision up to fourth sign after decimal point. The procedure should produce exact results working with the specified precision.
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN

IF ((SELECT count(id) from accounts where id = account_id) <> 1)  
or (money_amount > (SELECT balance from accounts where id = account_id)) 
or (money_amount <= 0)  
THEN ROLLBACK;
 ELSE
UPDATE accounts
SET balance = balance - money_amount
where id = account_id;
END IF;
END $$
DELIMITER ;

SELECT * from accounts where id = 1;
call usp_withdraw_money(1, 10);
SELECT * from accounts where id = 1;

-- 14
-- Write stored procedure usp_transfer_money(from_account_id, to_account_id, amount) that transfers money from one account to another.
-- Consider cases when one of the account_ids is not valid, the amount of money is negative number, 
-- outgoing balance is enough or transferring from/to one and the same account. 
-- Make sure that the whole procedure passes without errors and if error occurs make no change in the database. 
DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, money_amount DECIMAL(19,4))
BEGIN 
DECLARE valid_money_amount boolean;
DECLARE valid_from_id boolean;
DECLARE valid_to_id boolean;
DECLARE valid_transaction boolean;
SET valid_money_amount = (money_amount > 0);
SET valid_from_id = ((SELECT count(id) from accounts where id = from_account_id) = 1);
SET valid_to_id = ((SELECT count(id) from accounts where id = to_account_id) = 1);
SET valid_transaction = ((SELECT balance from accounts where id = from_account_id) >= money_amount);

IF(valid_money_amount AND valid_from_id AND valid_to_id AND valid_transaction) 
THEN 
UPDATE accounts
SET balance = balance - money_amount
where id = from_account_id;
UPDATE accounts 
SET 
    balance = balance + money_amount
WHERE
    id = to_account_id;
ELSE
ROLLBACK;
END IF;
END $$
DELIMITER ;

-- 15
-- Create another table – logs(log_id, account_id, old_sum, new_sum)
-- Add a trigger to the accounts table that enters a new entry into the logs table every time the sum on an account changes

CREATE TABLE `logs` (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    old_sum DECIMAL(19 , 4 ),
    new_sum DECIMAL(19 , 4 )
);
DELIMITER $$
CREATE 
    TRIGGER  t_updated_sum
 AFTER UPDATE ON accounts FOR EACH ROW 
    BEGIN
    if (old.balance <> new.balance) then 
    insert into logs(account_id, old_sum, new_sum) value (old.id, old.balance, new.balance);
    end if;
    END$$
DELIMITER ;
-- 16
-- Create another table – notification_emails(id, recipient, subject, body).
-- Add a trigger to logs table to create new email whenever new record is inserted in logs table.
-- The following data is required to be filled for each email:
-- • recipient – account_id
-- • subject – "Balance change for account: {account_id}"
-- • body - "On {date (current date)} your balance was changed from {old} to {new}."
CREATE TABLE notification_emails (
    id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT,
    subject TEXT,
    body TEXT
)

DELIMITER $$
CREATE trigger t_notifications
AFTEr insert on `logs` for each row
begin
insert into notification_emails(recipient, subject, body) 
value (
new.account_id, 
concat ('Balance change for account: ', new.account_id), 
concat ('On ', date_format(now(), '%b %d %y at %r' ),' your balance was changed from ', new.old_sum, ' to ', new.new_sum, '.'));
end $$
DELIMITER ;