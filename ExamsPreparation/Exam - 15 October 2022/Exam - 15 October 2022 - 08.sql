-- There are many items in our menu list, but the owner wants to know which one is the best sellable item from the restaurant.
-- Extract from the database the id(product), the name and the count of products from all orders with this name where the count is greater or equal to 5.
-- Order the results descending by count and then by name in ascending.
SELECT 
    p.id AS id, p.`name` AS `name`, COUNT(op.order_id) AS count
FROM
    products AS p
        JOIN
    orders_products op ON p.id = op.product_id
GROUP BY product_id
HAVING COUNT(op.order_id) >= 5
ORDER BY COUNT(op.order_id) DESC , p.`name` ASC;