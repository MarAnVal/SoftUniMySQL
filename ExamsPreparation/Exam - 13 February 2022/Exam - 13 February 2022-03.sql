-- Reduce all products quantity by 5 for products with quantity equal to or greater than 60 and less than 70 (inclusive).

UPDATE products 
SET 
    quantity_in_stock = quantity_in_stock - 5
WHERE
    quantity_in_stock BETWEEN 60 AND 70;