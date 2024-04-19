-- Create a stored procedure udp_graduate_all_students_by_year(year_started INT)
-- Extracts data about all courses that started on the given year, find the assigned students and change their graduated status to true.
DELIMITER $$
CREATE PROCEDURE udp_graduate_all_students_by_year(year_started INT)
BEGIN
UPDATE students
set is_graduated = true
WHERE id in (select * from (SELECT 
    s.id
FROM
    courses AS c
        JOIN
    students_courses AS sc ON c.id = sc.course_id
        JOIN
    students AS s ON s.id = sc.student_id
WHERE
    YEAR(c.start_date) = year_started) as x);
END $$
DELIMITER ;

CALL udp_graduate_all_students_by_year(2017); 

SELECT 
    s.first_name ,
s.last_name, s.id, s.is_graduated
FROM
    courses AS c
        JOIN
    students_courses AS sc ON c.id = sc.course_id
        JOIN
    students AS s ON s.id = sc.student_id
WHERE
    YEAR(c.start_date) = 2017;




