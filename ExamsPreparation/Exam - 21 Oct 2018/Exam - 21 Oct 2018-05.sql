SELECT 
    id, CONCAT_WS(' ', first_name, last_name), ucn
FROM
    colonists
ORDER BY first_name , last_name , id;