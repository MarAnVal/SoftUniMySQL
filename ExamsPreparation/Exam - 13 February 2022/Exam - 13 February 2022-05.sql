-- Extract from the online_store system database, info about the name of categories.
-- Order the results by category_name in descending order;
SELECT 
    id, `name`
FROM
    categories
ORDER BY `name` DESC;