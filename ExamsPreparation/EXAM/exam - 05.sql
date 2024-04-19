-- Extract from the universities_db system database, info about the cities.
-- Order the results by population in descending order;
SELECT 
    id, `name`, population, country_id
FROM
    cities
ORDER BY population DESC;