-- Extract from the database all the cars and the count of their courses. 
-- Also display the average bill of each course by the car, rounded to the second digit.
-- Order the results descending by the count of courses, then by the car’s id. 
-- Skip the cars with exactly 2 courses.

SELECT 
    c.id AS car_id,
    c.make AS make,
    c.mileage AS mileage,
    COUNT(cr.id) AS count_of_courses,
    ROUND(AVG(cr.bill), 2) AS avg_bill
FROM
    cars AS c
        LEFT JOIN
    courses AS cr ON c.id = cr.car_id
GROUP BY c.id
HAVING COUNT(cr.id) <> 2
ORDER BY count_of_courses DESC , car_id ASC;
