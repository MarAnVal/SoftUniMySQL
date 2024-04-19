-- After a lot of manipulations on our base, now we must clean up.
-- Delete all games from table games, which do not have a category and release date. 

DELETE FROM games 
WHERE
    id NOT IN (SELECT 
        game_id
    FROM
        games_categories)
    AND release_date IS NULL;
    

    
    