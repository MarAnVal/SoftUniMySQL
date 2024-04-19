-- There are many customers in our shop system, but we need to find only those who are clients from the beginning of the online store creation.
-- Extract from the database, the full name of customer, the address, and the date of order. The year must be lower or equal to 2018.
-- Order the results descending by full_name.
SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS full_name,
    c.address AS address,
    o.order_datetime AS order_datetime
FROM
    customers AS c
        JOIN
    orders AS o ON c.id = o.customer_id
WHERE
    YEAR(o.order_datetime) <= 2018
ORDER BY full_name DESC;