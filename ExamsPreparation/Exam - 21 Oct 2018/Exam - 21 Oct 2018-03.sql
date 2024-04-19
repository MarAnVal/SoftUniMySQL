-- REMOVE from colonists, those which are not assigned to any journey.
DELETE FROM colonists 
WHERE
    id NOT IN (SELECT 
        t.colonist_id
    FROM
        travel_cards AS t);