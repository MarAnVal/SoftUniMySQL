-- Create a stored procedure udp_reduce_price(category_name (VARCHAR(50))
-- Extracts data about the products from the given category and reduces the prices by 30% of all 
-- products which have reviews with rating less than 4 and are from the given category.
DELIMITER $$
CREATE PROCEDURE udp_reduce_price(category_name VARCHAR(50))
BEGIN
UPDATE products
SET price = 0.7 * price
WHERE id in (
select * from(
SELECT 
    p.id
FROM
    reviews AS r
        JOIN
    products AS p ON r.id = p.review_id
        JOIN
    categories AS c ON c.id = p.category_id
WHERE
    c.`name` = category_name
        AND r.rating < 4
        ) as a);
END$$
DELIMITER ;

SELECT 
    p.id, p.`name`
FROM
    reviews AS r
        JOIN
    products AS p ON r.id = p.review_id
        JOIN
    categories AS c ON c.id = p.category_id
WHERE
    c.`name` = 'Phones and tablets'
        AND r.rating < 4;
        