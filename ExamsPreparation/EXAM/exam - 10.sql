-- Create a user defined function with the name udf_average_alumni_grade_by_course_name(course_name VARCHAR(60))
-- that receives a course name and returns the average grades of the grades from those students that are graduated.
-- Required Columns
-- course_name
-- average_alumni_grade (udf_average_alumni_grade_by_course_name)
DELIMITER $$
CREATE FUNCTION udf_average_alumni_grade_by_course_name(course_name VARCHAR(60))
RETURNS VARCHAR (4)
BEGIN
DECLARE course_id int(11);
DECLARE result FLOAT;
SET course_id = (SELECT 
            id
        FROM
            courses
        WHERE
            `name` = course_name);   
set result = (
SELECT 
    AVG(sc.grade) as count
FROM
    students_courses AS sc
        JOIN
    students AS s
        JOIN
    students_courses ON s.id = sc.student_id
WHERE
    s.is_graduated IS TRUE
        AND sc.course_id = course_id
        LIMIT 1);
            
RETURN format(round(result, 2), 2);
END$$
DELIMITER ;

SELECT c.name, udf_average_alumni_grade_by_course_name('Quantum Physics') as average_alumni_grade FROM courses c 
WHERE c.name = 'Quantum Physics';

