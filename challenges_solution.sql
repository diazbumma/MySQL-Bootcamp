/* CREATING TABLE*/
CREATE TABLE pastries (name VARCHAR(50), quantity INT);
SHOW COLUMNS FROM pastries;
DROP TABLE pastries;

/* INSERT CHALLENGES */
CREATE TABLE people (
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  age INT
);
INSERT INTO people (first_name, last_name, age) VALUES ('Tina', 'Belcher', 13);
INSERT INTO people (first_name, last_name, age) VALUES ('Bob', 'Belcher', 42);
INSERT INTO people (first_name, last_name, age) VALUES
  ('Linda', 'Belcher', 45),
  ('Phillip', 'Frond', 38),
  ('Calvin', 'Fischoeder', 70);

/* TABLE CONSTRAINTS */
CREATE TABLE employees (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  last_name VARCHAR(100) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100),
  age INT NOT NULL,
  current_status VARCHAR(20) NOT NULL DEFAULT 'employed'
);

/* SELECT CHALLENGES */
SELECT cat_id FROM cats;
SELECT name, breed FROM cats;
SELECT name, age FROM cats WHERE breed = 'Tabby';
SELECT cat_id, age FROM cats WHERE cat_id = age;

/* UPDATE CHALLENGES */
UPDATE cats SET name = 'Jack' WHERE name = 'Jackson';
UPDATE cats SET breed = 'British Shorthair' WHERE name = 'Ringo';
UPDATE cats SET age =  12 WHERE breed = 'Maine Coon';

/* DELETE CHALLENGES */
DELETE FROM cats WHERE age = 4;
DELETE FROM cats WHERE age = cat_id;
DELETE FROM cats;

/* CRUD EXERCISE */
CREATE TABLE shirts (
  shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  article VARCHAR(50),
  color VARCHAR(50),
  shirt_size VARCHAR(5),
  last_worn INT
);
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES
  ('t-shirt', 'white', 'S', 10),
  ('t-shirt', 'green', 'S', 200),
  ('polo shirt', 'black', 'M', 10),
  ('tank top', 'blue', 'S', 50),
  ('t-shirt', 'pink', 'S', 0),
  ('polo shirt', 'red', 'M', 5),
  ('tank top', 'white', 'S', 200),
  ('tank top', 'blue', 'M', 15);
SELECT * FROM shirts;
INSERT INTO shirts (color, article, shirt_size, last_worn) VALUES ('purple', 'polo shirt', 'M', 50);
SELECT article, color FROM shirts;
SELECT article, color, shirt_size, last_worn FROM shirts WHERE shirt_size = 'M';
UPDATE shirts SET shirt_size = 'L' WHERE article = 'polo shirt';
UPDATE shirts SET last_worn = 0 WHERE last_worn = 15;
UPDATE shirts SET shirt_size = 'XS', color = 'off white' WHERE color = 'white';
DELETE FROM shirts WHERE last_worn = 200;
DELETE FROM shirts WHERE article = 'tank top';
DELETE FROM shirts;
DROP TABLE shirts;

/* STRING FUNCTION CHALLENGES */
SELECT REVERSE(UPPER('Why does my cat look at me with such hatred?'));
SELECT REPLACE(title, ' ', '->') AS title FROM books;
SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;
SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps' FROM books;
SELECT CONCAT(title, ' was released in ', released_year) AS blurb FROM books;
SELECT title, CHAR_LENGTH(title) AS 'character count' FROM books;
SELECT
  CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title',
  CONCAT(author_lname, ',', author_fname) AS author,
  CONCAT(stock_quantity, ' in stock') AS quantity
FROM books;

/* REFINING SELECTIONS EXERCISES */
SELECT title FROM books WHERE title LIKE '%stories%';
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;
SELECT CONCAT(title, ' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';
SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity, title LIMIT 3;
SELECT title, author_lname FROM books ORDER BY author_lname, title;
SELECT UPPER(
  CONCAT(
    'MY FAVORITE AUTHOR IS ',
    author_fname,
    ' ',
    author_lname,
    '!'
  )
) AS yell FROM books ORDER BY author_lname;

/* AGGREGATE FUNCTIONS CHALLENGES */
SELECT COUNT(*) FROM books;
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
SELECT SUM(stock_quantity) FROM books;
SELECT author_fname, author_lname, AVG(released_year) FROM books GROUP BY author_fname, author_lname;
SELECT CONCAT(author_fname, ' ', author_lname) FROM books WHERE pages = (SELECT MAX(pages) FROM books);
SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages' FROM books GROUP BY released_year;

/* DATA TYPES EXERCISES */
SELECT CURTIME();
SELECT CURDATE();
SELECT DAYOFWEEK(CURDATE());
SELECT DATE_FORMAT(CURDATE(), '%W');
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
SELECT DATE_FORMAT(NOW(), '%M %D at %H:%i');
CREATE TABLE tweets (
  tweet_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  content VARCHAR(255),
  username VARCHAR(255),
  created_at TIMESTAMP DEFAULT NOW()
);

/* LOGICAL OPERATOR EXERCISES SOLUTIONS */
SELECT * FROM books WHERE released_year < 1980;
SELECT * FROM books WHERE author_lname = 'Eggers' OR author_lname = 'Chabon';
SELECT * FROM books WHERE author_lname = 'Lahiri' AND released_year > 2000;
SELECT * FROM books WHERE pages BETWEEN 100 AND 200;
SELECT * FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';
SELECT title, author_lname,
  CASE
    WHEN title LIKE '%stories%' THEN 'Short Stories'
    WHEN title LIKE '%Just Kids%' OR title LIKE '%A Heartbreaking Work%' THEN 'Memoir'
    ELSE 'Novel'
  END AS TYPES
FROM books;
SELECT title, author_lname,
  CASE
    WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*), ' books')
    ELSE '1 book'
  END AS 'COUNT'
FROM books GROUP BY author_fname, author_lname ORDER BY author_lname;

/* FIRST JOINS EXERCISE */
DROP DATABASE IF EXISTS student_papers;
CREATE DATABASE student_papers;
USE student_papers;

CREATE TABLE students (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  first_name VARCHAR(255)
);

CREATE TABLE papers (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  title VARCHAR(255),
  grade INT,
  student_id INT,
  FOREIGN KEY(student_id) REFERENCES students(id)
  ON DELETE CASCADE
);

SELECT first_name, title, grade FROM students INNER JOIN papers
ON students.id = papers.student_id ORDER BY grade DESC;

SELECT first_name, title, grade FROM students LEFT JOIN papers
ON students.id = papers.student_id;

SELECT
  first_name,
  IFNULL(title, 'MISSING') AS title,
  IFNULL(grade, 0) AS grade
FROM students LEFT JOIN papers ON students.id = papers.student_id;

SELECT
  first_name,
  IFNULL(AVG(grade), 0) AS average
FROM students LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

SELECT
  first_name,
  IFNULL(AVG(grade), 0) AS average,
  CASE
    WHEN IFNULL(AVG(grade), 0) >= 75 THEN 'PASSING'
    ELSE 'FAILING'
  END AS passing_status
FROM students LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

/* Many to many challenges */
SELECT title, rating FROM series INNER JOIN reviews ON series.id = reviews.series_id;

SELECT title, AVG(rating) AS avg_rating FROM series INNER JOIN reviews
  ON series.id = reviews.series_id
  GROUP BY series.id
  ORDER BY avg_rating;

SELECT first_name, last_name, rating FROM reviewers INNER JOIN reviews ON reviewers.id = reviews.reviewer_id;

SELECT title AS unreviewed_series FROM series LEFT JOIN reviews ON series.id = reviews.series_id
WHERE rating IS NULL;

SELECT genre, AVG(rating) AS avg_rating FROM series INNER JOIN reviews ON series.id = reviews.series_id
GROUP BY genre;

SELECT
  first_name,
  last_name,
  COUNT(rating) AS COUNT,
  IFNULL(ROUND(MIN(rating), 1), 0) AS MIN,
  IFNULL(ROUND(MAX(rating), 1), 0) AS MAX,
  IFNULL(AVG(rating), 0) AS AVG,
  -- IF(COUNT(rating) = 0, 'INACTIVE', 'ACTIVE') AS STATUS
  CASE
    WHEN COUNT(rating) = 0 THEN 'INACTIVE'
    ELSE 'ACTIVE'
  END AS STATUS
FROM reviewers LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

SELECT title, rating, reviewer FROM series INNER JOIN (
  (SELECT
    series_id,
    rating,
    CONCAT(first_name, ' ', last_name) AS reviewer
    FROM reviews INNER JOIN reviewers ON reviews.reviewer_id = reviewers.id) AS ratings
) ON series.id = ratings.series_id
ORDER BY title;

SELECT
  title,
  rating,
  CONCAT(first_name, ' ', last_name) AS reviewer
FROM series
INNER JOIN reviews
  ON series.id = reviews.series_id
INNER JOIN reviewers
  ON reviews.reviewer_id = reviewers.id
ORDER BY title;
