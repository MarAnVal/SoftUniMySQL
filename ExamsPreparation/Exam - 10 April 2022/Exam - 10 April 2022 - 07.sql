-- Some actors are free and can apply the casting for a new movie. You must search for them and prepare their documents.
-- Write a query that returns:  full name, email, age and height for all actors that are not participating in a movie.
-- To find their email you must take their last name reversed followed by the number of characters of their last name and then the casting email “@cast.com”

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    CONCAT(REVERSE(a.last_name),
            CHAR_LENGTH(last_name),
            '@cast.com') AS email,
    (2022 - YEAR(birthdate)) AS age,
    a.height AS height
FROM
    actors AS a
        LEFT JOIN
    movies_actors AS ma ON a.id = ma.actor_id
WHERE
    ma.movie_id IS NULL
ORDER BY height ASC;