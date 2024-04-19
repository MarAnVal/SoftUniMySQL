-- Delete all customers, who didn't order anything.

DELETE FROM customers 
WHERE
    id NOT IN (SELECT 
        *
    FROM
        (SELECT DISTINCT
            customer_id
        FROM
            orders) as a);