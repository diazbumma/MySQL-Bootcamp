-- Case statements (like if-else statements in programming language)
SELECT title, released_year,
  CASE
      WHEN released_year >= 2000 THEN 'Modern Lit'
      ELSE '20th Century Lit'
  END AS GENRE
FROM books;

SELECT title, stock_quantity,
  CASE
    WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
    WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
    ELSE '***'
  END AS STOCK
FROM books;

-- Where clause with IN and NOT IN
SELECT title, released_year FROM books WHERE released_year IN (2001, 2002, 2005);
SELECT title, released_year FROM books WHERE released_year NOT IN (2001, 2002, 2005);

-- Syntax to create table with foreign key
CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(255)
);
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_date DATE,
  amount DECIMAL(8,2),
  customer_id INT,                                    --holds customer data
  FOREIGN KEY(customer_id) REFERENCES customers(id)   --assigns customer_id as references of id in customers table
);
