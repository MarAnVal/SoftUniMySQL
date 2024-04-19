-- Create a user defined function with the name udf_actor_history_movies_count(full_name VARCHAR(50))
--  that receives an actor’s full name and returns the total number of history movies in which the actor has a role.
DELIMITER $$
CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50))
RETURNS INT
BEGIN
DECLARE history_id int;
DECLARE actor_id int;
SET history_id = (
SELECT 
    g.id
FROM
    genres AS g
WHERE
    g.`name` = 'history'
);
SET actor_id = (
SELECT 
    a.id
FROM
    actors AS a
WHERE
    CONCAT_WS(' ', first_name, last_name) = full_name
);
RETURN(
SELECT 
    COUNT(*)
FROM
    genres_movies AS gm
        JOIN
    movies_actors AS ma ON gm.movie_id = ma.movie_id
WHERE
    ma.actor_id = actor_id
    AND gm.genre_id = history_id
);
END $$
DELIMITER ;

