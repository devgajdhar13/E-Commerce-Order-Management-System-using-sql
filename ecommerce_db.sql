
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> REATE DATABASE ecommerce_db;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'REATE DATABASE ecommerce_db' at line 1
mysql> CREATE DATABASE ecommerce_db;
Query OK, 1 row affected (0.06 sec)

mysql> USE ecommerce_db;
Database changed
mysql> CREATE TABLE Categories (
    ->     category_id   INT AUTO_INCREMENT PRIMARY KEY,
    ->     category_name VARCHAR(100) NOT NULL
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> CREATE TABLE Products (
    ->     product_id     INT AUTO_INCREMENT PRIMARY KEY,
    ->     name           VARCHAR(150)   NOT NULL,
    ->     category_id    INT            NOT NULL,
    ->     price          DECIMAL(10,2)  NOT NULL,
    ->     stock_quantity INT            NOT NULL DEFAULT 0,
    ->     added_date     DATE           NOT NULL,
    ->     FOREIGN KEY (category_id) REFERENCES Categories(category_id)
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql> CREATE TABLE Customers (
    ->     customer_id       INT AUTO_INCREMENT PRIMARY KEY,
    ->     name              VARCHAR(100) NOT NULL,
    ->     email             VARCHAR(150),            -- can be missing
    ->     phone_number      VARCHAR(20),
    ->     address           VARCHAR(255),
    ->     registration_date DATE NOT NULL
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE Orders (
    ->     order_id     INT AUTO_INCREMENT PRIMARY KEY,
    ->     customer_id  INT NOT NULL,
    ->     order_date   DATE NOT NULL,
    ->     total_amount DECIMAL(10,2) NOT NULL,
    ->     status       ENUM('Pending','Shipped','Delivered','Cancelled') NOT NULL,
    ->     FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE Order_Items (
    ->     order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     order_id      INT NOT NULL,
    ->     product_id    INT NOT NULL,
    ->     quantity      INT NOT NULL,
    ->     subtotal      DECIMAL(10,2) NOT NULL,
    ->     FOREIGN KEY (order_id)   REFERENCES Orders(order_id) ON DELETE CASCADE,
    ->     FOREIGN KEY (product_id) REFERENCES Products(product_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE Payments (
    ->     payment_id     INT AUTO_INCREMENT PRIMARY KEY,
    ->     order_id       INT NOT NULL,
    ->     payment_date   DATE NOT NULL,
    ->     payment_method ENUM('Credit Card','PayPal','UPI') NOT NULL,
    ->     payment_status ENUM('Paid','Pending','Failed') NOT NULL,
    ->     FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> CREATE TABLE Payments (
    ->     payment_id     INT AUTO_INCREMENT PRIMARY KEY,
    ->     order_id       INT NOT NULL,
    ->     payment_date   DATE NOT NULL,
    ->     payment_method ENUM('Credit Card','PayPal','UPI') NOT NULL,
    ->     payment_status ENUM('Paid','Pending','Failed') NOT NULL,
    ->     FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
    -> );
ERROR 1050 (42S01): Table 'payments' already exists
mysql> CREATE TABLE Shipping (
    ->     shipping_id     INT AUTO_INCREMENT PRIMARY KEY,
    ->     order_id        INT NOT NULL,
    ->     shipping_date   DATE NOT NULL,
    ->     delivery_date   DATE,                      -- empty until delivered
    ->     shipping_status ENUM('Dispatched','In Transit','Delivered') NOT NULL,
    ->     FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> INSERT INTO Categories (category_id, category_name) VALUES(1, 'Electronics'),(2, 'Clothing'),(3, 'Books');
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Products (product_id, name, category_id, price, stock_quantity, added_date) VALUES(1, 'Laptop',      1, 55000.00,   10, '2022-01-10'),(2, 'Smartphone',  1, 25000.00,   25, '2022-03-05'),(3, 'Headphones',  1,  2000.00,  100, '2022-06-18'),(4, 'T-Shirt',     2,   500.00, 1000, '2022-09-01'),(5, 'Jeans',       2,  1500.00,    0, '2022-09-01'),(6, 'Notebook',    3,    50.00, 2000, '2023-01-12'),(7, 'Smart Watch', 1,  8000.00,   15, '2023-04-20');
Query OK, 7 rows affected (0.01 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Customers (customer_id, name, email, phone_number, address, registration_date) VALUES(1, 'Rahul Sharma ', 'rahul@email.com', '9876500001', 'Surat, Gujarat',     '2021-05-10'),(2, ' Priya Patel',  'priya@email.com', '9876500002', 'Ahmedabad, Gujarat', '2022-08-20'),(3, 'Amit Shah',     NULL,              '9876500003', 'Vadodara, Gujarat',  '2023-02-14'),(4, 'Neha Verma',    '',                '9876500004', 'Mumbai, Maharashtra','2023-09-01'),(5, 'Karan Mehta',   'karan@email.com', '9876500005', 'Pune, Maharashtra',  '2024-01-15');  -- no orders
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(1,  1, DATE_SUB(CURDATE(), INTERVAL 300 DAY),  55000.00, 'Delivered'),(2,  1, DATE_SUB(CURDATE(), INTERVAL 100 DAY),   4000.00, 'Delivered'),(3,  1, DATE_SUB(CURDATE(), INTERVAL 60 DAY),    2000.00, 'Delivered'),(4,  1, DATE_SUB(CURDATE(), INTERVAL 20 DAY),     500.00, 'Pending'),(5,  2, DATE_SUB(CURDATE(), INTERVAL 90 DAY),    6000.00, 'Delivered'),(6,  2, DATE_SUB(CURDATE(), INTERVAL 3 DAY),     3000.00, 'Shipped'),(7,  3, DATE_SUB(CURDATE(), INTERVAL 10 DAY),    2000.00, 'Pending'),(8,  4, DATE_SUB(CURDATE(), INTERVAL 200 DAY), 105000.00, 'Delivered'),(9,  4, DATE_SUB(CURDATE(), INTERVAL 30 DAY),   26000.00, 'Delivered'),(10, 3, DATE_SUB(CURDATE(), INTERVAL 50 DAY),   25000.00, 'Cancelled'),   -- old cancelled order(11, 2, DATE_SUB(CURDATE(), INTERVAL 5 DAY),     2000.00, 'Cancelled');   -- recent cancelled order
    ->
    -> ^C
mysql>  INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(1,  1, DATE_SUB(CURDATE(), INTERVAL 300 DAY),  55000.00, 'Delivered'),(2,  1, DATE_SUB(CURDATE(), INTERVAL 100 DAY),   4000.00, 'Delivered'),(3,  1, DATE_SUB(CURDATE(), INTERVAL 60 DAY),    2000.00, 'Delivered'),(4,  1, DATE_SUB(CURDATE(), INTERVAL 20 DAY),     500.00, 'Pending'),(5,  2, DATE_SUB(CURDATE(), INTERVAL 90 DAY),    6000.00, 'Delivered'),(6,  2, DATE_SUB(CURDATE(), INTERVAL 3 DAY),     3000.00, 'Shipped'),(7,  3, DATE_SUB(CURDATE(), INTERVAL 10 DAY),    2000.00, 'Pending'),(8,  4, DATE_SUB(CURDATE(), INTERVAL 200 DAY), 105000.00, 'Delivered'),(9,  4, DATE_SUB(CURDATE(), INTERVAL 30 DAY),   26000.00, 'Delivered'),(10, 3, DATE_SUB(CURDATE(), INTERVAL 50 DAY),   25000.00, 'Cancelled'),   -- old cancelled order(11, 2, DATE_SUB(CURDATE(), INTERVAL 5 DAY),     2000.00, 'Cancelled');
    -> ^C
mysql> INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
    -> (1,  1, DATE_SUB(CURDATE(), INTERVAL 300 DAY),  55000.00, 'Delivered'),
    -> (2,  1, DATE_SUB(CURDATE(), INTERVAL 100 DAY),   4000.00, 'Delivered'),
    -> (3,  1, DATE_SUB(CURDATE(), INTERVAL 60 DAY),    2000.00, 'Delivered'),
    -> (4,  1, DATE_SUB(CURDATE(), INTERVAL 20 DAY),     500.00, 'Pending'),
    -> (5,  2, DATE_SUB(CURDATE(), INTERVAL 90 DAY),    6000.00, 'Delivered'),
    -> (6,  2, DATE_SUB(CURDATE(), INTERVAL 3 DAY),     3000.00, 'Shipped'),
    -> (7,  3, DATE_SUB(CURDATE(), INTERVAL 10 DAY),    2000.00, 'Pending'),
    -> (8,  4, DATE_SUB(CURDATE(), INTERVAL 200 DAY), 105000.00, 'Delivered'),
    -> (9,  4, DATE_SUB(CURDATE(), INTERVAL 30 DAY),   26000.00, 'Delivered'),
    -> (10, 3, DATE_SUB(CURDATE(), INTERVAL 50 DAY),   25000.00, 'Cancelled'),   -- old cancelled order
    -> (11, 2, DATE_SUB(CURDATE(), INTERVAL 5 DAY),     2000.00, 'Cancelled');   -- recent cancelled order
Query OK, 11 rows affected (0.01 sec)
Records: 11  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, subtotal) VALUES
    -> (1,  1, 1,   1,  55000.00),
    -> (2,  2, 3,   2,   4000.00),
    -> (3,  3, 4,   4,   2000.00),
    -> (4,  4, 6,  10,    500.00),
    -> (5,  5, 3,   3,   6000.00),
    -> (6,  6, 5,   2,   3000.00),
    -> (7,  7, 3,   1,   2000.00),
    -> (8,  8, 4, 210, 105000.00),
    -> (9,  9, 6, 520,  26000.00),
    -> (10, 10, 2,  1,  25000.00),
    -> (11, 11, 3,  1,   2000.00);
Query OK, 11 rows affected (0.01 sec)
Records: 11  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status) VALUES
    -> (1,  1,  DATE_SUB(CURDATE(), INTERVAL 300 DAY), 'Credit Card', 'Paid'),
    -> (2,  2,  DATE_SUB(CURDATE(), INTERVAL 100 DAY), 'PayPal',      'Paid'),
    -> (3,  3,  DATE_SUB(CURDATE(), INTERVAL 60 DAY),  'UPI',         'Paid'),
    -> (4,  4,  DATE_SUB(CURDATE(), INTERVAL 20 DAY),  'UPI',         'Pending'),
    -> (5,  5,  DATE_SUB(CURDATE(), INTERVAL 90 DAY),  'Credit Card', 'Paid'),
    -> (6,  6,  DATE_SUB(CURDATE(), INTERVAL 3 DAY),   'UPI',         'Paid'),
    -> (7,  7,  DATE_SUB(CURDATE(), INTERVAL 10 DAY),  'UPI',         'Paid'),
    -> (8,  8,  DATE_SUB(CURDATE(), INTERVAL 200 DAY), 'Credit Card', 'Paid'),
    -> (9,  9,  DATE_SUB(CURDATE(), INTERVAL 30 DAY),  'PayPal',      'Paid'),
    -> (10, 10, DATE_SUB(CURDATE(), INTERVAL 50 DAY),  'UPI',         'Failed'),
    -> (11, 11, DATE_SUB(CURDATE(), INTERVAL 5 DAY),   'Credit Card', 'Failed');
Query OK, 11 rows affected (0.01 sec)
Records: 11  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_status) VALUES
    -> (1, 1, DATE_SUB(CURDATE(), INTERVAL 299 DAY), DATE_SUB(CURDATE(), INTERVAL 295 DAY), 'Delivered'),
    -> (2, 2, DATE_SUB(CURDATE(), INTERVAL 99 DAY),  DATE_SUB(CURDATE(), INTERVAL 96 DAY),  'Delivered'),
    -> (3, 3, DATE_SUB(CURDATE(), INTERVAL 59 DAY),  DATE_SUB(CURDATE(), INTERVAL 55 DAY),  'Delivered'),
    -> (4, 5, DATE_SUB(CURDATE(), INTERVAL 89 DAY),  DATE_SUB(CURDATE(), INTERVAL 85 DAY),  'Delivered'),
    -> (5, 6, DATE_SUB(CURDATE(), INTERVAL 2 DAY),   NULL,                                  'In Transit'),
    -> (6, 8, DATE_SUB(CURDATE(), INTERVAL 199 DAY), DATE_SUB(CURDATE(), INTERVAL 194 DAY), 'Delivered'),
    -> (7, 9, DATE_SUB(CURDATE(), INTERVAL 29 DAY),  DATE_SUB(CURDATE(), INTERVAL 25 DAY),  'Delivered');
Query OK, 7 rows affected (0.01 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Products (product_id, name, category_id, price, stock_quantity, added_date)
    -> VALUES (8, 'Tablet', 1, 30000.00, 20, CURDATE());
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Customers (customer_id, name, email, phone_number, address, registration_date)
    -> VALUES (6, 'Sneha Iyer', 'sneha@email.com', '9876500006', 'Chennai, Tamil Nadu', CURDATE());
Query OK, 1 row affected (0.01 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status)
    -> VALUES (12, 3, CURDATE(), 30000.00, 'Pending');
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, subtotal)
    -> VALUES (12, 12, 8, 1, 30000.00);
Query OK, 1 row affected (0.00 sec)

mysql> UPDATE Products
    -> SET stock_quantity = stock_quantity - 1
    -> WHERE product_id = 8;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Orders
    -> WHERE status = 'Cancelled'
    ->   AND order_date < DATE_SUB(CURDATE(), INTERVAL 30 DAY);
Query OK, 1 row affected (0.03 sec)

mysql> SELECT order_id, customer_id, order_date, total_amount, status
    -> FROM Orders
    -> WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|        2 |           1 | 2026-06-26 |      4000.00 | Delivered |
|        3 |           1 | 2026-08-05 |      2000.00 | Delivered |
|        4 |           1 | 2026-09-14 |       500.00 | Pending   |
|        5 |           2 | 2026-07-06 |      6000.00 | Delivered |
|        6 |           2 | 2026-10-01 |      3000.00 | Shipped   |
|        7 |           3 | 2026-09-24 |      2000.00 | Pending   |
|        9 |           4 | 2026-09-04 |     26000.00 | Delivered |
|       11 |           2 | 2026-09-29 |      2000.00 | Cancelled |
|       12 |           3 | 2026-10-04 |     30000.00 | Pending   |
+----------+-------------+------------+--------------+-----------+
9 rows in set (0.01 sec)

mysql> SELECT product_id, name, price
    -> FROM Products
    -> ORDER BY price DESC
    -> LIMIT 5;
+------------+-------------+----------+
| product_id | name        | price    |
+------------+-------------+----------+
|          1 | Laptop      | 55000.00 |
|          8 | Tablet      | 30000.00 |
|          2 | Smartphone  | 25000.00 |
|          7 | Smart Watch |  8000.00 |
|          3 | Headphones  |  2000.00 |
+------------+-------------+----------+
5 rows in set (0.00 sec)

mysql> SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
    -> FROM Customers c
    -> INNER JOIN Orders o ON c.customer_id = o.customer_id
    -> GROUP BY c.customer_id, c.name
    -> HAVING COUNT(o.order_id) > 3;
+-------------+---------------+--------------+
| customer_id | name          | total_orders |
+-------------+---------------+--------------+
|           1 | Rahul Sharma  |            4 |
+-------------+---------------+--------------+
1 row in set (0.01 sec)

mysql> SELECT o.order_id, o.customer_id, o.order_date, o.total_amount,
    ->        o.status, p.payment_status
    -> FROM Orders o
    -> INNER JOIN Payments p ON o.order_id = p.order_id
    -> WHERE o.status = 'Pending'
    ->   AND p.payment_status = 'Paid';
+----------+-------------+------------+--------------+---------+----------------+
| order_id | customer_id | order_date | total_amount | status  | payment_status |
+----------+-------------+------------+--------------+---------+----------------+
|        7 |           3 | 2026-09-24 |      2000.00 | Pending | Paid           |
+----------+-------------+------------+--------------+---------+----------------+
1 row in set (0.00 sec)

mysql> SELECT product_id, name, stock_quantity
    -> FROM Products
    -> WHERE NOT (stock_quantity = 0);
+------------+-------------+----------------+
| product_id | name        | stock_quantity |
+------------+-------------+----------------+
|          1 | Laptop      |             10 |
|          2 | Smartphone  |             25 |
|          3 | Headphones  |            100 |
|          4 | T-Shirt     |           1000 |
|          6 | Notebook    |           2000 |
|          7 | Smart Watch |             15 |
|          8 | Tablet      |             19 |
+------------+-------------+----------------+
7 rows in set (0.00 sec)

mysql> SELECT DISTINCT c.customer_id, c.name, c.registration_date
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.customer_id = o.customer_id
    -> WHERE c.registration_date > '2022-12-31'
    ->    OR (o.total_amount > 10000 AND o.status <> 'Cancelled');
+-------------+---------------+-------------------+
| customer_id | name          | registration_date |
+-------------+---------------+-------------------+
|           1 | Rahul Sharma  | 2021-05-10        |
|           3 | Amit Shah     | 2023-02-14        |
|           4 | Neha Verma    | 2023-09-01        |
|           5 | Karan Mehta   | 2024-01-15        |
|           6 | Sneha Iyer    | 2026-10-04        |
+-------------+---------------+-------------------+
5 rows in set (0.00 sec)

mysql> SELECT product_id, name, price
    -> FROM Products
    -> ORDER BY price DESC;
+------------+-------------+----------+
| product_id | name        | price    |
+------------+-------------+----------+
|          1 | Laptop      | 55000.00 |
|          8 | Tablet      | 30000.00 |
|          2 | Smartphone  | 25000.00 |
|          7 | Smart Watch |  8000.00 |
|          3 | Headphones  |  2000.00 |
|          5 | Jeans       |  1500.00 |
|          4 | T-Shirt     |   500.00 |
|          6 | Notebook    |    50.00 |
+------------+-------------+----------+
8 rows in set (0.00 sec)

mysql> SELECT c.customer_id, c.name, COUNT(o.order_id) AS number_of_orders
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.customer_id = o.customer_id
    -> GROUP BY c.customer_id, c.name;
+-------------+---------------+------------------+
| customer_id | name          | number_of_orders |
+-------------+---------------+------------------+
|           1 | Rahul Sharma  |                4 |
|           2 |  Priya Patel  |                3 |
|           3 | Amit Shah     |                2 |
|           4 | Neha Verma    |                2 |
|           5 | Karan Mehta   |                0 |
|           6 | Sneha Iyer    |                0 |
+-------------+---------------+------------------+
6 rows in set (0.00 sec)

mysql> SELECT cat.category_name, SUM(oi.subtotal) AS total_revenue
    -> FROM Categories cat
    -> INNER JOIN Products p     ON cat.category_id = p.category_id
    -> INNER JOIN Order_Items oi ON p.product_id = oi.product_id
    -> INNER JOIN Orders o       ON oi.order_id = o.order_id
    -> WHERE o.status <> 'Cancelled'
    -> GROUP BY cat.category_id, cat.category_name
    -> ORDER BY total_revenue DESC;
+---------------+---------------+
| category_name | total_revenue |
+---------------+---------------+
| Clothing      |     110000.00 |
| Electronics   |      97000.00 |
| Books         |      26500.00 |
+---------------+---------------+
3 rows in set (0.00 sec)

mysql> SELECT SUM(total_amount) AS total_revenue
    -> FROM Orders
    -> WHERE status <> 'Cancelled';
+---------------+
| total_revenue |
+---------------+
|     233500.00 |
+---------------+
1 row in set (0.01 sec)

mysql> SELECT p.product_id, p.name, SUM(oi.quantity) AS total_units_sold
    -> FROM Products p
    -> INNER JOIN Order_Items oi ON p.product_id = oi.product_id
    -> INNER JOIN Orders o       ON oi.order_id = o.order_id
    -> WHERE o.status <> 'Cancelled'
    -> GROUP BY p.product_id, p.name
    -> ORDER BY total_units_sold DESC
    -> LIMIT 1;
+------------+----------+------------------+
| product_id | name     | total_units_sold |
+------------+----------+------------------+
|          6 | Notebook |              530 |
+------------+----------+------------------+
1 row in set (0.00 sec)

mysql> -- 5c. Average order value
mysql> SELECT AVG(total_amount) AS average_order_value
    -> FROM Orders
    -> WHERE status <> 'Cancelled';
+---------------------+
| average_order_value |
+---------------------+
|        23350.000000 |
+---------------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*)          AS number_of_orders,
    ->        MAX(total_amount) AS biggest_order,
    ->        MIN(total_amount) AS smallest_order
    -> FROM Orders
    -> WHERE status <> 'Cancelled';
+------------------+---------------+----------------+
| number_of_orders | biggest_order | smallest_order |
+------------------+---------------+----------------+
|               10 |     105000.00 |         500.00 |
+------------------+---------------+----------------+
1 row in set (0.00 sec)

mysql> SELECT p.product_id, p.name AS product_name, cat.category_name
    -> FROM Products p
    -> INNER JOIN Categories cat ON p.category_id = cat.category_id;
+------------+--------------+---------------+
| product_id | product_name | category_name |
+------------+--------------+---------------+
|          1 | Laptop       | Electronics   |
|          2 | Smartphone   | Electronics   |
|          3 | Headphones   | Electronics   |
|          7 | Smart Watch  | Electronics   |
|          8 | Tablet       | Electronics   |
|          4 | T-Shirt      | Clothing      |
|          5 | Jeans        | Clothing      |
|          6 | Notebook     | Books         |
+------------+--------------+---------------+
8 rows in set (0.00 sec)

mysql> SELECT o.order_id, o.order_date, o.total_amount, o.status,
    ->        c.customer_id, c.name, c.email
    -> FROM Orders o
    -> LEFT JOIN Customers c ON o.customer_id = c.customer_id;
+----------+------------+--------------+-----------+-------------+---------------+-----------------+
| order_id | order_date | total_amount | status    | customer_id | name          | email           |
+----------+------------+--------------+-----------+-------------+---------------+-----------------+
|        1 | 2025-12-08 |     55000.00 | Delivered |           1 | Rahul Sharma  | rahul@email.com |
|        2 | 2026-06-26 |      4000.00 | Delivered |           1 | Rahul Sharma  | rahul@email.com |
|        3 | 2026-08-05 |      2000.00 | Delivered |           1 | Rahul Sharma  | rahul@email.com |
|        4 | 2026-09-14 |       500.00 | Pending   |           1 | Rahul Sharma  | rahul@email.com |
|        5 | 2026-07-06 |      6000.00 | Delivered |           2 |  Priya Patel  | priya@email.com |
|        6 | 2026-10-01 |      3000.00 | Shipped   |           2 |  Priya Patel  | priya@email.com |
|        7 | 2026-09-24 |      2000.00 | Pending   |           3 | Amit Shah     | NULL            |
|        8 | 2026-03-18 |    105000.00 | Delivered |           4 | Neha Verma    |                 |
|        9 | 2026-09-04 |     26000.00 | Delivered |           4 | Neha Verma    |                 |
|       11 | 2026-09-29 |      2000.00 | Cancelled |           2 |  Priya Patel  | priya@email.com |
|       12 | 2026-10-04 |     30000.00 | Pending   |           3 | Amit Shah     | NULL            |
+----------+------------+--------------+-----------+-------------+---------------+-----------------+
11 rows in set (0.00 sec)

mysql> SELECT o.order_id, o.order_date, o.total_amount, o.status
    -> FROM Shipping s
    -> RIGHT JOIN Orders o ON s.order_id = o.order_id
    -> WHERE s.shipping_id IS NULL;
+----------+------------+--------------+-----------+
| order_id | order_date | total_amount | status    |
+----------+------------+--------------+-----------+
|        4 | 2026-09-14 |       500.00 | Pending   |
|        7 | 2026-09-24 |      2000.00 | Pending   |
|       11 | 2026-09-29 |      2000.00 | Cancelled |
|       12 | 2026-10-04 |     30000.00 | Pending   |
+----------+------------+--------------+-----------+
4 rows in set (0.00 sec)

mysql> SELECT customer_id, customer_name
    -> FROM (
    ->     SELECT c.customer_id, c.name AS customer_name, o.order_id
    ->     FROM Customers c
    ->     LEFT JOIN Orders o ON c.customer_id = o.customer_id
    ->     UNION
    ->     SELECT c.customer_id, c.name AS customer_name, o.order_id
    ->     FROM Customers c
    ->     RIGHT JOIN Orders o ON c.customer_id = o.customer_id
    -> ) AS full_join
    -> WHERE order_id IS NULL;
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
|           5 | Karan Mehta   |
|           6 | Sneha Iyer    |
+-------------+---------------+
2 rows in set (0.00 sec)

mysql> SELECT order_id, customer_id, order_date, total_amount, status
    -> FROM Orders
    -> WHERE customer_id IN (
    ->     SELECT customer_id
    ->     FROM Customers
    ->     WHERE registration_date > '2022-12-31'
    -> );
+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|        7 |           3 | 2026-09-24 |      2000.00 | Pending   |
|       12 |           3 | 2026-10-04 |     30000.00 | Pending   |
|        8 |           4 | 2026-03-18 |    105000.00 | Delivered |
|        9 |           4 | 2026-09-04 |     26000.00 | Delivered |
+----------+-------------+------------+--------------+-----------+
4 rows in set (0.00 sec)

mysql> SELECT customer_id, name
    -> FROM Customers
    -> WHERE customer_id = (
    ->     SELECT customer_id
    ->     FROM Orders
    ->     WHERE status <> 'Cancelled'
    ->     GROUP BY customer_id
    ->     ORDER BY SUM(total_amount) DESC
    ->     LIMIT 1
    -> );
+-------------+------------+
| customer_id | name       |
+-------------+------------+
|           4 | Neha Verma |
+-------------+------------+
1 row in set (0.00 sec)

mysql> SELECT product_id, name
    -> FROM Products
    -> WHERE product_id NOT IN (
    ->     SELECT product_id
    ->     FROM Order_Items
    -> );
+------------+-------------+
| product_id | name        |
+------------+-------------+
|          2 | Smartphone  |
|          7 | Smart Watch |
+------------+-------------+
2 rows in set (0.00 sec)

mysql> SELECT YEAR(order_date)  AS order_year,
    ->        MONTH(order_date) AS order_month,
    ->        COUNT(*)          AS total_orders
    -> FROM Orders
    -> GROUP BY YEAR(order_date), MONTH(order_date)
    -> ORDER BY order_year, order_month;
+------------+-------------+--------------+
| order_year | order_month | total_orders |
+------------+-------------+--------------+
|       2025 |          12 |            1 |
|       2026 |           3 |            1 |
|       2026 |           6 |            1 |
|       2026 |           7 |            1 |
|       2026 |           8 |            1 |
|       2026 |           9 |            4 |
|       2026 |          10 |            2 |
+------------+-------------+--------------+
7 rows in set (0.00 sec)

mysql> SELECT order_id, shipping_date, delivery_date,
    ->        DATEDIFF(delivery_date, shipping_date) AS delivery_days
    -> FROM Shipping
    -> WHERE delivery_date IS NOT NULL;
+----------+---------------+---------------+---------------+
| order_id | shipping_date | delivery_date | delivery_days |
+----------+---------------+---------------+---------------+
|        1 | 2025-12-09    | 2025-12-13    |             4 |
|        2 | 2026-06-27    | 2026-06-30    |             3 |
|        3 | 2026-08-06    | 2026-08-10    |             4 |
|        5 | 2026-07-07    | 2026-07-11    |             4 |
|        8 | 2026-03-19    | 2026-03-24    |             5 |
|        9 | 2026-09-05    | 2026-09-09    |             4 |
+----------+---------------+---------------+---------------+
6 rows in set (0.00 sec)

mysql> SELECT order_id,
    ->        DATE_FORMAT(order_date, '%d-%m-%Y') AS formatted_order_date
    -> FROM Orders;
+----------+----------------------+
| order_id | formatted_order_date |
+----------+----------------------+
|        1 | 08-12-2025           |
|        2 | 26-06-2026           |
|        3 | 05-08-2026           |
|        4 | 14-09-2026           |
|        5 | 06-07-2026           |
|        6 | 01-10-2026           |
|        7 | 24-09-2026           |
|        8 | 18-03-2026           |
|        9 | 04-09-2026           |
|       11 | 29-09-2026           |
|       12 | 04-10-2026           |
+----------+----------------------+
11 rows in set (0.03 sec)

mysql> SELECT product_id, UPPER(name) AS product_name_upper
    -> FROM Products;
+------------+--------------------+
| product_id | product_name_upper |
+------------+--------------------+
|          1 | LAPTOP             |
|          2 | SMARTPHONE         |
|          3 | HEADPHONES         |
|          4 | T-SHIRT            |
|          5 | JEANS              |
|          6 | NOTEBOOK           |
|          7 | SMART WATCH        |
|          8 | TABLET             |
+------------+--------------------+
8 rows in set (0.01 sec)

mysql> SELECT customer_id, name AS original_name, TRIM(name) AS trimmed_name
    -> FROM Customers;
+-------------+---------------+--------------+
| customer_id | original_name | trimmed_name |
+-------------+---------------+--------------+
|           1 | Rahul Sharma  | Rahul Sharma |
|           2 |  Priya Patel  | Priya Patel  |
|           3 | Amit Shah     | Amit Shah    |
|           4 | Neha Verma    | Neha Verma   |
|           5 | Karan Mehta   | Karan Mehta  |
|           6 | Sneha Iyer    | Sneha Iyer   |
+-------------+---------------+--------------+
6 rows in set (0.00 sec)

mysql> SELECT customer_id, TRIM(name) AS customer_name,
    ->        COALESCE(NULLIF(TRIM(email), ''), 'Not Provided') AS email
    -> FROM Customers;
+-------------+---------------+-----------------+
| customer_id | customer_name | email           |
+-------------+---------------+-----------------+
|           1 | Rahul Sharma  | rahul@email.com |
|           2 | Priya Patel   | priya@email.com |
|           3 | Amit Shah     | Not Provided    |
|           4 | Neha Verma    | Not Provided    |
|           5 | Karan Mehta   | karan@email.com |
|           6 | Sneha Iyer    | sneha@email.com |
+-------------+---------------+-----------------+
6 rows in set (0.01 sec)

mysql> SELECT c.customer_id,
    ->        TRIM(c.name) AS customer_name,
    ->        COALESCE(SUM(o.total_amount), 0) AS total_spent,
    ->        RANK() OVER (ORDER BY COALESCE(SUM(o.total_amount), 0) DESC) AS spending_rank
    -> FROM Customers c
    -> LEFT JOIN Orders o
    ->        ON c.customer_id = o.customer_id
    ->       AND o.status <> 'Cancelled'
    -> GROUP BY c.customer_id, c.name;
+-------------+---------------+-------------+---------------+
| customer_id | customer_name | total_spent | spending_rank |
+-------------+---------------+-------------+---------------+
|           4 | Neha Verma    |   131000.00 |             1 |
|           1 | Rahul Sharma  |    61500.00 |             2 |
|           3 | Amit Shah     |    32000.00 |             3 |
|           2 | Priya Patel   |     9000.00 |             4 |
|           5 | Karan Mehta   |        0.00 |             5 |
|           6 | Sneha Iyer    |        0.00 |             5 |
+-------------+---------------+-------------+---------------+
6 rows in set (0.00 sec)

mysql> SELECT revenue_month,
    ->        monthly_revenue,
    ->        SUM(monthly_revenue) OVER (ORDER BY revenue_month) AS cumulative_revenue
    -> FROM (
    ->     SELECT DATE_FORMAT(order_date, '%Y-%m') AS revenue_month,
    ->            SUM(total_amount)                AS monthly_revenue
    ->     FROM Orders
    ->     WHERE status <> 'Cancelled'
    ->     GROUP BY DATE_FORMAT(order_date, '%Y-%m')
    -> ) AS monthly;
+---------------+-----------------+--------------------+
| revenue_month | monthly_revenue | cumulative_revenue |
+---------------+-----------------+--------------------+
| 2025-12       |        55000.00 |           55000.00 |
| 2026-03       |       105000.00 |          160000.00 |
| 2026-06       |         4000.00 |          164000.00 |
| 2026-07       |         6000.00 |          170000.00 |
| 2026-08       |         2000.00 |          172000.00 |
| 2026-09       |        28500.00 |          200500.00 |
| 2026-10       |        33000.00 |          233500.00 |
+---------------+-----------------+--------------------+
7 rows in set (0.00 sec)

mysql> SELECT order_id, order_date,
    ->        COUNT(*) OVER (
    ->            ORDER BY order_date, order_id
    ->            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ->        ) AS running_total_orders
    -> FROM Orders;
+----------+------------+----------------------+
| order_id | order_date | running_total_orders |
+----------+------------+----------------------+
|        1 | 2025-12-08 |                    1 |
|        8 | 2026-03-18 |                    2 |
|        2 | 2026-06-26 |                    3 |
|        5 | 2026-07-06 |                    4 |
|        3 | 2026-08-05 |                    5 |
|        9 | 2026-09-04 |                    6 |
|        4 | 2026-09-14 |                    7 |
|        7 | 2026-09-24 |                    8 |
|       11 | 2026-09-29 |                    9 |
|        6 | 2026-10-01 |                   10 |
|       12 | 2026-10-04 |                   11 |
+----------+------------+----------------------+
11 rows in set (0.00 sec)

mysql> SELECT customer_id, customer_name, total_spent,
    ->        CASE
    ->            WHEN total_spent > 50000  THEN 'Gold'
    ->            WHEN total_spent >= 20000 THEN 'Silver'
    ->            ELSE 'Bronze'
    ->        END AS Loyalty_Status
    -> FROM (
    ->     SELECT c.customer_id,
    ->            TRIM(c.name) AS customer_name,
    ->            COALESCE(SUM(o.total_amount), 0) AS total_spent
    ->     FROM Customers c
    ->     LEFT JOIN Orders o
    ->            ON c.customer_id = o.customer_id
    ->           AND o.status <> 'Cancelled'
    ->     GROUP BY c.customer_id, c.name
    -> ) AS customer_spending;
+-------------+---------------+-------------+----------------+
| customer_id | customer_name | total_spent | Loyalty_Status |
+-------------+---------------+-------------+----------------+
|           1 | Rahul Sharma  |    61500.00 | Gold           |
|           2 | Priya Patel   |     9000.00 | Bronze         |
|           3 | Amit Shah     |    32000.00 | Silver         |
|           4 | Neha Verma    |   131000.00 | Gold           |
|           5 | Karan Mehta   |        0.00 | Bronze         |
|           6 | Sneha Iyer    |        0.00 | Bronze         |
+-------------+---------------+-------------+----------------+
6 rows in set (0.00 sec)

mysql>
mysql> SELECT product_id, name, units_sold,
    ->        CASE
    ->            WHEN units_sold > 500  THEN 'Best Seller'
    ->            WHEN units_sold >= 200 THEN 'Popular'
    ->            ELSE 'Regular'
    ->        END AS product_category
    -> FROM (
    ->     SELECT p.product_id, p.name,
    ->            COALESCE(s.units, 0) AS units_sold
    ->     FROM Products p
    ->     LEFT JOIN (
    ->         SELECT oi.product_id, SUM(oi.quantity) AS units
    ->         FROM Order_Items oi
    ->         INNER JOIN Orders o ON oi.order_id = o.order_id
    ->         WHERE o.status <> 'Cancelled'
    ->         GROUP BY oi.product_id
    ->     ) AS s ON p.product_id = s.product_id
    -> ) AS product_sales;
+------------+-------------+------------+------------------+
| product_id | name        | units_sold | product_category |
+------------+-------------+------------+------------------+
|          1 | Laptop      |          1 | Regular          |
|          2 | Smartphone  |          0 | Regular          |
|          3 | Headphones  |          6 | Regular          |
|          4 | T-Shirt     |        214 | Popular          |
|          5 | Jeans       |          2 | Regular          |
|          6 | Notebook    |        530 | Best Seller      |
|          7 | Smart Watch |          0 | Regular          |
|          8 | Tablet      |          1 | Regular          |
+------------+-------------+------------+------------------+
8 rows in set (0.00 sec)