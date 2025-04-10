-- Query to list all books with authors and publishers
SELECT b.title, a.author_name, p.publisher_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
JOIN publisher p ON b.publisher_id = p.publisher_id; 

-- Query to find customer orders with shipping details
SELECT 
    c.first_name, c.last_name, 
    co.order_date, sm.method_name, sm.cost,
    os.status_name
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN shipping_method sm ON co.shipping_method_id = sm.method_id
JOIN order_history oh ON co.order_id = oh.order_id
JOIN order_status os ON oh.status_id = os.status_id; 

-- Query to calculate the total sales per customer
SELECT 
    c.first_name, c.last_name,
    SUM(ol.quantity * ol.price) AS total_spent
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY c.customer_id;

