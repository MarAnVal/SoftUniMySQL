-- Create a user defined function with the name udf_users_photos_count(username VARCHAR(30))
--  that receives a username and returns the number of photos this user has upload.
DELIMITER $$
create FUNCTION udf_users_photos_count(username VARCHAR(30))
RETURNS int(11)
begin
return (select
count(up.photo_id) as count
from 
users as u
left join users_photos as up on u.id = user_id
where u.username = username);
end$$
DELIMITER ;

SELECT udf_users_photos_count('ssantryd') AS photosCount;
