-- A movie has won an award. Your task is to find all actors and give them the award.
-- Create a stored procedure udp_award_movie(movie_title(VARCHAR(50))
-- Extracts data about the movie with the given title and find all actors that play in it and increase their awards with 1.

DELIMITER $$
CREATE PROCEDURE udp_award_movie(movie_title VARCHAR(50))
BEGIN
DECLARE movie_id int;
SET movie_id = (
SELECT 
    m.id
FROM
    movies as m
WHERE
    title = movie_title
);

UPDATE actors 
SET 
    awards = awards + 1
WHERE
    id IN (SELECT 
            *
        FROM
            (SELECT 
                ma.actor_id
            FROM
                movies_actors AS ma
            WHERE
                ma.movie_id = movie_id) AS x);
END $$
DELIMITER ;