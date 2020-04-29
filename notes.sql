--change timestamp using ON UPDATE
CREATE TABLE caption (
  caption_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  content VARCHAR(255),
  username VARCHAR(255),
  updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
);

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
  ON DELETE CASCADE                                   --deletes record when the foreign record deleted
);

CREATE TABLE photo_tags (
  photo_id INT NOT NULL,
  tag_id INT NOT NULL,
  FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (photo_id, tag_id)                      --make sure combinations of two id won't be repeated
);

-- Database triggers
DELIMITER $$

CREATE TRIGGER prevent_self_follows
    BEFORE INSERT ON follows FOR EACH ROW                   --Trigger executed before query
    BEGIN
        IF NEW.follower_id = NEW.followee_id
        THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Cannot follow yourself'
        END IF;
    END;
$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER create_unfollow
    AFTER DELETE ON follows FOR EACH ROW                    --Trigger executed after query
BEGIN
    INSERT INTO unfollows
    SET follower_id = OLD.follower_id,
        followee_id = OLD.followee_id;
END$$

DELIMITER ;

-- Managing triggers
SHOW TRIGGERS;
DROP TRIGGER create_unfollow;
