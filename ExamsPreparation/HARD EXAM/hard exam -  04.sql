-- Naturally, unpopular profiles are being treated as abandoned. 
-- DELETE all users which do NOT follow anyone and no one follows them.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM users 
WHERE
    id IN (select * from (SELECT 
        u1.id
    FROM
        users AS u1    
    WHERE
        u1.id NOT IN (SELECT 
            uf1.user_id
        FROM
            users_followers AS uf1)
        AND u1.id NOT IN (SELECT 
            uf2.follower_id
        FROM
            users_followers AS uf2)) as a);