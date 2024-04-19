-- UPDATE all users which do NOT have a profile picture. 
-- Set their profile picture id to the count of followers they have. 
-- If they have 0, set it to the user’s id.

UPDATE users AS u 
SET 
    profile_picture_id = (CASE
        WHEN
            (SELECT 
                    COUNT(uf.follower_id)
                FROM
                    users_followers AS uf
                WHERE
                    uf.user_id = u.id) > 0
        THEN
            (SELECT 
                    COUNT(uf.follower_id)
                FROM
                    users_followers AS uf
                WHERE
                    uf.user_id = u.id)
        ELSE u.id
    END)
WHERE
    u.profile_picture_id IS NULL;

