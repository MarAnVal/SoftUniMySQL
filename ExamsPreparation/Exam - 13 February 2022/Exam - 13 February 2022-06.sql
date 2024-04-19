-- Write a query that returns: product_id, brand_id, name and quantity from table products. 
-- Filter products which price is higher than 1000 and their quantity is lower than 30.
-- Order the results ascending by quantity_in_stock, then by id.
SELECT 
    id, brand_id, `name`, quantity_in_stock
FROM
    products
WHERE
    price > 1000 AND quantity_in_stock < 30
ORDER BY quantity_in_stock , id;