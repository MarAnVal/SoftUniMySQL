-- You will have to insert records of data into the products table, based on the waiters table.
-- For waiters with id greater than 6, insert data in the products table with the following values:

INSERT INTO products(`name`, `type`, price)
SELECT 
-- •	name – set it to the last name of the waiter followed by white space and then "specialty".  (last_name + " " + "specialty")
concat_ws(' ', w.last_name, 'specialty') as `name`,
-- •	type – set it to the "Cocktail".
'Cocktail' as `type`,
-- •	price – set it to 1% of the waiter salary and round the DECIMAL always to the next largest number CEIL.
ceil(0.01 * w.salary) as price
FROM
        waiters AS w
    WHERE
        id > 6;