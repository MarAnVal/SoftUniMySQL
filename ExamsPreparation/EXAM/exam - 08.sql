-- Every university has courses with students. The directors of every university want to know the total number of students assigned to courses.
-- Extract from the database the students_count (total number of assigned students) in each university
--  and the corresponding university_name. Get only those universities with students_count equal or greater than 8. 
-- Order the results descending by students_count and then by university_name in descending order. 
SELECT 
    COUNT(sc.student_id) AS students_count,
    u.`name` AS university_name
FROM
    universities AS u
        JOIN
    courses AS c ON u.id = c.university_id
        JOIN
    students_courses AS sc ON c.id = course_id
GROUP BY u.id
HAVING students_count >= 8
ORDER BY students_count DESC , university_name DESC;