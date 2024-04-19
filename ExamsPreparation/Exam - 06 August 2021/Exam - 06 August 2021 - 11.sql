-- We will have to increase the support of the games that do not have any categories yet. 
-- We should find them and increase their budget, as well as push their release date
-- The procedure must increase the budget by 100,000 and add one year to their release_date to the games that do not 
-- have any categories and their rating is more than (not equal) the given parameter min_game_rating and release date is NOT NULL.
-- Create a stored procedure udp_update_budget which accepts the following parameters:
-- min_game_rating(floating point number) 
DELIMITER $$
create PROCEDURE udp_update_budget (min_game_rating FLOAT)
begin
UPDATE games 
SET 
    budget = budget + 100000
WHERE
    id IN (select * from (SELECT 
            g.id
        FROM
            games AS g
                LEFT JOIN
            games_categories AS gc ON g.id = gc.game_id
        WHERE
            gc.category_id IS NULL
                AND g.release_date IS NOT NULL
                AND rating > min_game_rating)as a);
    
UPDATE games 
SET 
    release_date = CONCAT(YEAR(release_date) + 1,
            '-',
            MONTH(release_date),
            '-',
            DAY(release_date))
WHERE
    id IN (SELECT 
            *
        FROM
            (SELECT 
                g.id
            FROM
                games AS g
            LEFT JOIN games_categories AS gc ON g.id = gc.game_id
            WHERE
                gc.category_id IS NULL
                    AND g.release_date IS NOT NULL
                    AND rating > min_game_rating) AS a);
END$$
DELIMITER ;