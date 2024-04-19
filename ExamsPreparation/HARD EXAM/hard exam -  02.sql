-- You will have to INSERT records of data into the comments table, based on the posts table. 
-- For posts with id between 1 and 10, insert data in the comments table with the following values:
-- content – set it to “Omg!{name}!This is so cool!”. Where the name is the username of the user that posted the post.
-- user_id – MULTIPLY the id of the post by 3 and DIVIDE it by 2.
-- ROUND the resulting value UP.
-- post_id – the post’s id.

INSERT INTO comments(content,user_id,post_id)
SELECT 
    (SELECT 
            CONCAT('Omg!', u.username, '!This is so cool!')
        FROM
            users AS u
        WHERE
            u.id = user_id
        LIMIT 1) AS content,
    (CEIL(p.id * 3 / 2)) AS user_id,
    p.id AS post_id
FROM
    posts AS p
WHERE
    p.id BETWEEN 1 AND 10;

select * from comments order by id DESC;