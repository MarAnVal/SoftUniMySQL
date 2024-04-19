-- Extract from the database those photos that their upload day is 10 and summarize their description. 
-- The summary must be 30 symbols long plus "..." at the end. 
-- Order the results by date descending order. 

SELECT 
    concat(substring(`description`, 1, 30), '...') AS summary,
    `date`
FROM
    photos
WHERE
    DAY(`date`) = 10
ORDER BY `date` DESC;