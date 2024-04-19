-- Update all coaches, who train one or more players and their first_name starts with ‘A’. Increase their level with 1.
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

UPDATE coaches AS c
        LEFT JOIN
    players_coaches AS pc ON c.id = pc.coach_id 
SET 
    c.coach_level = c.coach_level + 1
WHERE
    c.first_name LIKE 'A%'
        AND pc.player_id IS NOT NULL;
