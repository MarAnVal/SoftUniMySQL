-- Extract the regular clients, who have ridden in more than one car. 
-- The second letter of the customer's full name must be 'a'. 
-- Select the full name, the count of cars that he ridden and total sum of all courses.
-- Order clients by their full_name.

SELECT 
    a.full_name AS full_name,
    (SELECT 
            COUNT(*)
        FROM
            (SELECT DISTINCT
                cr.car_id
            FROM
                courses AS cr
            WHERE
                a.id = cr.client_id) AS x) AS count_of_cars,
    (SELECT 
            SUM(f.bill)
        FROM
            courses AS f
        WHERE
            a.id = f.client_id) AS total_sum
FROM
    clients AS a
WHERE
    a.full_name LIKE '_a%'
        AND (SELECT 
            COUNT(*)
        FROM
            (SELECT DISTINCT
                cr.car_id
            FROM
                courses AS cr
            WHERE
                a.id = cr.client_id) AS x) > 1
ORDER BY full_name;

select * from clients as cl join courses as cr on cr.client_id = cl.id ORDER BY cl.full_name;