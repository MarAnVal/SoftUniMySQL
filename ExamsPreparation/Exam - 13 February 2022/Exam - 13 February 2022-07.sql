-- Write a query that returns: id, content, rating, picture_url and published_at for all reviews
--  which content starts with ‘My’ and the characters of the content are more than 61 symbols.
-- Order by rating in descending order.
SELECT 
    id, content, rating, picture_url, published_at
FROM
    reviews
WHERE
    content LIKE 'My%'
        AND CHAR_LENGTH(content) > 61
ORDER BY rating DESC;