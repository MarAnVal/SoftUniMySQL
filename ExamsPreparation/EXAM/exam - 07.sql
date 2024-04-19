-- There are some students that are not signed up for any course but want to be registered in the system with accounts. 
-- To find the account details write a query that returns: full_name, username and password for all students who do not have any assigned course. 
 -- Order by password in descending order.
SELECT 
    (CONCAT_WS(' ', first_name, last_name)) AS full_name,
    (SUBSTRING(email, 2, 10)) AS username,
    (REVERSE(phone)) AS `password`
FROM
    students
WHERE
    id NOT IN (SELECT 
            student_id AS id
        FROM
            students_courses)
ORDER BY `password` DESC;