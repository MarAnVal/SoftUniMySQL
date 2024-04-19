-- You will have to insert records of data into the courses table, based on the courses table.
-- For courses with id equal or lesser than 5, insert data in the course table with the following values:
insert into courses (`name`, duration_hours, start_date, teacher_name, `description`, university_id)
select
concat_ws(' ', c.teacher_name, 'course') as`name`,
-- name – set it to the teacher name followed by white space and then "course"
(char_length(c.`name`) / 10) as duration_hours,
-- set it to the total number of characters from the course name and the result devided by 10.
(select DATE_SUB(c.start_date, INTERVAL -5 day)) as start_date,
-- set it to the start date of the course but 5 days later.
(reverse(c.teacher_name)) as teacher_name,
-- set it to the teacher name but reversed. 
(concat('Course ', c.teacher_name, reverse(c.`description`))) as `description`,
-- set it to "Course " followed by the teacher name and the description but reversed.
(day(c.start_date)) as university_id
 -- set it to the day of the start date of the original course.
from courses as c
where c.id <= 5;

select * from courses;