-- The waiters needs to have access to the new software, so they need personal accounts.
-- Your task is to generate their usernames and passwords.
-- Write a query that returns: username and password for all waiters which are not fired (fired waiter is a waiter without salary). 
-- The username is generated by their last name immediately followed by their first name  
-- followed by the number of characters from first name and at the end "Restaurant". T
-- he password is their email starting from the 2nd character to the 13th character and then reversed.
-- Order by password in descending order.

SELECT 
    CONCAT(last_name,
            first_name,
            CHAR_LENGTH(first_name),
            'Restaurant') AS username,
    REVERSE(SUBSTRING(email, 2, 12)) AS `password`
FROM
    waiters
WHERE
    salary IS NOT NULL
ORDER BY `password` DESC;