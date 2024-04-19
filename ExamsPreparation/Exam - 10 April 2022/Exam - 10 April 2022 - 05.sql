-- Extract from the softuni_imdb system database, info about the name of countries.
-- Order the results by currency in descending order and then by id.
SELECT 
    id, `name`, continent, currency
FROM
    countries
ORDER BY currency DESC , id;