-- Extract from the database all the team names and their addresses. Also display the count of the characters of the address names.
-- Skip those teams whose office does not have a website. 
-- Order the results by team names, then by the address names. 
SELECT 
    t.`name` AS team_name,
    a.`name` AS address_name,
    CHAR_LENGTH(a.`name`)
FROM
    teams AS t
        JOIN
    offices AS o ON o.id = t.office_id
        JOIN
    addresses AS a ON a.id = o.address_id
WHERE
    o.website IS NOT NULL
ORDER BY team_name , address_name;