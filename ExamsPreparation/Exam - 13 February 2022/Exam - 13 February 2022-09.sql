-- Extract from the database, the top 5 categories.
-- Order the results descending by items count, then by total_quantity in ascending. 
SELECT 
    COUNT(p.id) AS items_count,
    c.`name` AS `name`,
    SUM(p.quantity_in_stock) AS total_quantity
FROM
    products AS p
        RIGHT JOIN
    categories AS c ON c.id = p.category_id
GROUP BY c.id
ORDER BY items_count DESC , total_quantity ASC LIMIT 5;
