-- From the database extract the title, rating, subtitles, and the budget of movies. 
-- If the rating is equal or less than 4 the user must see “poor”,
-- 							above 4 and less or equal to 7 “good” 
--                             and above that it should display “excellent”. 
-- If the movie has subtitles the user should see “english”, otherwise “-“.
 
SELECT 
    m.title AS title,
    (CASE
        WHEN mai.rating <= 4 THEN 'poor'
        WHEN mai.rating > 7 THEN 'excellent'
        ELSE 'good'
    END) AS rating,
    IF(mai.has_subtitles, 'english', '-') AS subtitles,
    mai.budget AS budget
FROM
    movies AS m
        JOIN
    movies_additional_info AS mai ON mai.id = m.movie_info_id
ORDER BY budget DESC;