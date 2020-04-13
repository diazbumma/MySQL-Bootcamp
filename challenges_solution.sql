/* CREATING TABLE*/
CREATE TABLE pastries (name VARCHAR(50), quantity INT);
SHOW COLUMNS FROM pastries;
DROP TABLE pastries;

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
