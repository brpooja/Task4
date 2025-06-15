CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Table: Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(50)
);

-- Table: Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Table: Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table: OrderDetails
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Customers
INSERT INTO Customers VALUES
(1, 'Alice', 'alice@example.com', 'Mumbai'),
(2, 'Bob', 'bob@example.com', 'Delhi'),
(3, 'Charlie', 'charlie@example.com', 'Bangalore');

-- Products
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Smartphone', 'Electronics', 25000),
(103, 'Shoes', 'Footwear', 2000);

-- Orders
INSERT INTO Orders VALUES
(1001, 1, '2025-06-01'),
(1002, 2, '2025-06-02'),
(1003, 1, '2025-06-03');

-- OrderDetails
INSERT INTO OrderDetails VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1003, 101, 1),
(5, 1003, 102, 1);

-- List all customers from Mumbai
SELECT * FROM Customers WHERE city = 'Mumbai' ORDER BY name;

-- Total quantity sold for each product
SELECT p.name, SUM(od.quantity) AS total_sold
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.name;

-- Order details with customer and product info
SELECT o.order_id, c.name AS customer_name, p.name AS product_name, od.quantity
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;

-- All customers and their orders (if any)
SELECT c.name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- Products and their orders (if any)
SELECT p.name, od.order_id
FROM Products p
RIGHT JOIN OrderDetails od ON p.product_id = od.product_id;

-- Products ordered more than once
SELECT name FROM Products
WHERE product_id IN (
    SELECT product_id FROM OrderDetails GROUP BY product_id HAVING SUM(quantity) > 1
);

-- Create a view of order summary
CREATE VIEW OrderSummary AS
SELECT o.order_id, c.name AS customer_name, SUM(p.price * od.quantity) AS total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY o.order_id, c.name;

SELECT * FROM OrderSummary;

CREATE INDEX idx_order_date ON Orders(order_date);
