-- Some of the clients have not used the services of our company recently, so we need to remove them from the database.	
-- Delete all clients from clients table, that do not have any courses and the count of the characters in the full_name is more than 3 characters. 
DELETE FROM clients 
WHERE
    id IN (SELECT 
        a.id
    FROM
        (SELECT 
            c.id
        FROM
            clients AS c
        LEFT JOIN courses AS cs ON cs.client_id = c.id
        
        WHERE
            cs.id IS NULL
            AND CHAR_LENGTH(c.full_name) > 3) as a);