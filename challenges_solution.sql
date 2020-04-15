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
