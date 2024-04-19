-- You will have to insert records of data into the reviews table, based on the products table.
-- For products with id equal or greater than 5, insert data in the reviews table with the following values:
-- •	content – set it to the first 15 characters from the description of the product.
-- •	picture_url – set it to the product's name but reversed.
-- •	published_at – set it to 10-10-2010.
-- •	rating – set it to the price of the product divided by 8.

insert into reviews(content, rating, picture_url, published_at)
select 
(substring(p.`description`, 1, 15)) as content,
(p.price / 8) as rating,
(reverse(p.`name`)) as picture_url,
('2010-10-10') as published_at
from products as p
where p.id >= 5;