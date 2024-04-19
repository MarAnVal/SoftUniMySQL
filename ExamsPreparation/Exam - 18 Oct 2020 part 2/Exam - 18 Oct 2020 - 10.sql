-- CREATE user define procedure udp_update_product_price (address_name VARCHAR (50)), 
-- that receives as parameter an address name.
-- Increase the product's price with 100 if the address starts with 0 (zero) otherwise increase the price with 200.

DELIMITER $$
CREATE PROCEDURE udp_update_product_price (address_name VARCHAR (50))
BEGIN
UPDATE products as p
join products_stores as ps on p.id = ps.product_id
join stores as s on s.id = ps.store_id
join addresses as a on a.id = address_id

SET 
    price = (IF(SUBSTR(address_name, 1, 1) = '0',
        p.price + 100,
        p.price + 200))
      where a.`name` = address_name;  
END$$
DELIMITER ;


CALL udp_update_product_price('07 Armistice Parkway');
SELECT name, price FROM products WHERE id = 15;

select * from products as p
join products_stores as ps on p.id = ps.product_id
join stores as s on s.id = ps.store_id
join addresses as a on a.id = address_id
where a.`name` <> '07 Armistice Parkway'
order by p.id;