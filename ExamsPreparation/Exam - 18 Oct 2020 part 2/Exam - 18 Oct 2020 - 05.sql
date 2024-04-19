-- A photographer wants to take pictures of products that have old pictures. 
-- You must select all of the products that have a description more than 100 characters long description,
--  and a picture that is made before 2019 (exclusive) and the product price being more than 20. 
--  Select a short description column that consists of first 10 characters of the picture's description plus '…'. 
--  Order the results by product price in descending order.

SELECT 
    pro.`name`,
    pro.price,
    pro.best_before,
    CONCAT(SUBSTRING(pro.`description`, 1, 10),
            '...') AS short_description,
    pic.url
FROM
    products AS pro
        JOIN
    pictures AS pic ON pro.picture_id = pic.id
WHERE
    CHAR_LENGTH(pro.`description`) > 100
        AND pro.price > 20
        AND YEAR(added_on) < 2019
ORDER BY pro.price DESC;