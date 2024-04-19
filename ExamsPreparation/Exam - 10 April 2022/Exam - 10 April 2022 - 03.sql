-- Reduce all movies runtime by 10 minutes for movies
-- with movies_additional_info id equal to or greater than 15 and less than 25 (inclusive).

UPDATE movies_additional_info 
SET 
    runtime = runtime - 10
WHERE
    id BETWEEN 15 AND 25;
    
    SELECT SUM(m.runtime) FROM movies_additional_info m;
    
SELECT SUM(m.runtime) FROM movies_additional_info m;
-- 32397