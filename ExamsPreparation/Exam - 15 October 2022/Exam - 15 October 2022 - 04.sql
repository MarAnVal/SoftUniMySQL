-- Delete all waiters, who don't have any orders.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM waiters 
WHERE
    id NOT IN (SELECT 
        o.waiter_id
    FROM
        orders AS o);