USE bookstore_db;

-- 1. Book Language Table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- 2. Publisher Table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL
);

-- 3. Author Table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

-- 4. Book Table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publisher_id INT,
    language_id INT,
    num_pages INT,
    publication_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- 5. Book-Author (Many-to-Many Relationship)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 6. Country Table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- 7. Address Status Table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- 8. Address Table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_number VARCHAR(20) NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country_id INT,
    postal_code VARCHAR(20),
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 9. Customer Table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

-- 10. Customer Address Table
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 11. Shipping Method Table
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2)
);

-- 12. Order Status Table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- 13. Customer Order Table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id)
);

-- 14. Order Line Table (Books in Order)
CREATE TABLE order_line (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT DEFAULT 1,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 15. Order History Table (Status Changes)
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
-- Insert sample data into book_language
INSERT INTO book_language (language_name) VALUES ('Swahili'), ('Kamba'), ('Italian');

-- Insert publishers
INSERT INTO publisher (publisher_name) VALUES ('KIE'), ('Longhorn'), ('Oxford');

-- Insert authors
INSERT INTO author (author_name) VALUES ('V.M Kamole'), ('Fiona Omondi'), ('Beth Njoki');

-- Insert books
INSERT INTO book (title, isbn, publisher_id, language_id, num_pages, price)
VALUES 
('The River & the source', '94792947293', 1, 1, 320, 12.99),
('You', '97834534534', 2, 1, 510, 9.99),
('The Mannequin', '9780120475432', 3, 1, 320, 8.99);

-- Link books to authors (book_author)
INSERT INTO book_author (book_id, author_id) VALUES (1, 1), (2, 2), (3, 3);

-- Insert countries
INSERT INTO country (country_name) VALUES ('Kenya'), ('Uganda'), ('Burundi');

-- Insert address statuses
INSERT INTO address_status (status_name) VALUES ('Current'), ('Previous');

-- Insert addresses
INSERT INTO address (street_number, street_name, city, country_id, postal_code)
VALUES 
('401', 'Sgt Kahande', 'Eastleigh', 1, '05003'),
('201', 'Max Tap', 'Nakuru', 2, 'Vegas');

-- Insert customers
INSERT INTO customer (first_name, last_name, email, phone)
VALUES 
('Mathew', 'Adama', 'adamamat@example.com', '020-345-425'),
('Blake', 'Bourne', 'bbourne@example.com', '020-346-5200');

-- Link customers to addresses
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES (1, 1, 1), (2, 2, 1);

-- Insert shipping methods
INSERT INTO shipping_method (method_name, cost) VALUES ('Standard', 5.99), ('Express', 12.99);

-- Insert order statuses
INSERT INTO order_status (status_name) VALUES ('Pending'), ('Shipped'), ('Delivered');

-- Insert orders
INSERT INTO cust_order (customer_id, shipping_method_id)
VALUES (1, 1), (2, 2);

-- Insert order lines (books in orders)
INSERT INTO order_line (order_id, book_id, quantity, price)
VALUES (1, 1, 1, 12.99), (2, 2, 2, 19.98);

-- Insert order history (status changes)
INSERT INTO order_history (order_id, status_id)
VALUES (1, 1), (2, 1), (1, 2), (2, 3);

-- Create roles
CREATE ROLE bookstore_manager,bookstore_staff;

-- Assign privileges to roles
GRANT ALL ON bookstore_db.* TO bookstore_manager;
GRANT SELECT,UPDATE ON bookstore_db.* TO bookstore_staff;

-- Create users
CREATE USER 'mary'@'localhost'
IDENTIFIED BY "1234";

CREATE USER 'luke'@'localhost'
IDENTIFIED BY "5678";

CREATE USER 'nate'@'localhost'
IDENTIFIED BY "91011";

-- Assign roles to users
GRANT bookstore_manager TO mary@localhost;
GRANT bookstore_staff TO luke@localhost;
GRANT bookstore_staff TO nate@localhost;

FLUSH PRIVILEGES;