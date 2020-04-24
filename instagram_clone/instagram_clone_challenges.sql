-- FINDING 5 OLDEST USERS
SELECT * FROM users ORDER BY created_at LIMIT 5;

--DAY OF THE WEEK DO MOST USERS REGISTER ON
SELECT DAYNAME(created_at) AS day FROM users
  GROUP BY day
  ORDER BY COUNT(day) DESC LIMIT 2;

--FIND USERS WHO HAVE NEVER POSTED A PHOTO
SELECT users.* FROM users LEFT JOIN photos ON users.id = photos.user_id WHERE photos.id IS NULL;

--FIND USERS WHO GET THE MOST LIKES ON A SINGLE photos
SELECT users.*, photos.*, COUNT(*) AS photo_likes FROM likes
  INNER JOIN photos ON likes.photo_id = photos.id
  INNER JOIN users ON photos.user_id = users.id
  GROUP BY likes.photo_id
  ORDER BY photo_likes DESC LIMIT 1;

--FIND HOW MANY TIMES DOES THE AVERAGE USER POST
--inactive users not included
SELECT AVG(post_count) AS post_average FROM (
  (SELECT COUNT(*) AS post_count FROM users
    INNER JOIN photos ON users.id = photos.user_id
    GROUP BY users.id) AS count
);
--all users included
SELECT (SELECT COUNT(*) FROM photos)/(SELECT COUNT(*) FROM users) AS post_average;

--FIND 5 MOST POPULAR TAGS
SELECT tag_name, COUNT(*) AS count_tags FROM tags
  INNER JOIN photo_tags ON tags.id = photo_tags.tag_id
  GROUP BY tags.id
  ORDER BY count_tags DESC LIMIT 5;

--FIND USER WHO HAVE LIKED EVERY SINGLE PHOTO ON THE SITE
SELECT users.*, COUNT(*) AS count_likes FROM users
  INNER JOIN likes ON users.id = likes.user_id
  GROUP BY users.id
  HAVING count_likes = (
    SELECT COUNT(*) FROM photos
  );
