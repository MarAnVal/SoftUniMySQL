-- Write a query that returns: title, runtime, budget and release_date from table movies_additional_info.
-- Filter movies which have been released from 1996 to 1999 year (inclusive).
-- Order the results ascending by runtime then by id and show only the first 20 results.
SELECT 
    m.id AS id,
    m.title AS title,
    mai.runtime AS runtime,
    mai.budget AS budget,
    mai.release_date AS release_date
FROM
    movies_additional_info AS mai
        JOIN
    movies AS m ON mai.id = m.movie_info_id
WHERE
    YEAR(release_date) BETWEEN 1996 AND 1999
ORDER BY runtime ASC , id ASC
LIMIT 20;

