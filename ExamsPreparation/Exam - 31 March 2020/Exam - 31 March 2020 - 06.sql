-- Extract from the database, 5 most commented photos with their count of comments. 
-- Sort the results by commentsCount, descending, then by id in ascending order.

SELECT 
    p.id AS id,
    p.`date` AS date_and_time,
    p.`description` AS `description`,
    COUNT(c.id) AS commentsCount
FROM
    photos AS p
        LEFT JOIN
    comments AS c ON p.id = c.photo_id
GROUP BY p.id
ORDER BY commentsCount DESC , id ASC
LIMIT 5;