-- Create a user defined function with the name udf_customer_products_count(name VARCHAR(30))
--  that receives a customer’s first name and returns the total number of products he ordered;
DELIMITER $$
CREATE FUNCTION udf_customer_products_count(`name` VARCHAR(30))
returns INT
BEGIN
RETURN (
SELECT 
    COUNT(op.product_id) as total_products
FROM
    customers AS c
        JOIN
    orders AS o ON c.id = o.customer_id
        JOIN
    orders_products AS op ON o.id = op.order_id
WHERE
    c.first_name = `name`
GROUP BY c.id
);
END$$
DELIMITER ;