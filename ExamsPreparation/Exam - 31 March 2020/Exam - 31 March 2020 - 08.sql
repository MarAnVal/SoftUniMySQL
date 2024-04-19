-- Extract from the database, photos id with their likes and comments. 
-- Order them by count of likes descending, then by comments count descending and lastly by photo id ascending.
SELECT 
    p.id AS photo_id,
    (SELECT 
            COUNT(l.id)
        FROM
            likes AS l
        WHERE
            p.id = photo_id) AS likes_count,
    (SELECT 
            COUNT(c.id)
        FROM
            comments AS c
        WHERE
            p.id = photo_id) AS comments_count
FROM
    photos AS p
ORDER BY likes_count DESC , comments_count DESC , photo_id ASC;