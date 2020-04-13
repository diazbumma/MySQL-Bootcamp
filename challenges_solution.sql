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
