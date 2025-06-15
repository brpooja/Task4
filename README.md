# Task4

#  Ecommerce Database Project

This project demonstrates the creation and usage of a basic **Ecommerce Database** using SQL. It includes schema design, data insertion, and various SQL queries for data analysis and reporting.

## Database: `EcommerceDB`

###  Tables Created:

* **Customers**: Stores customer information
* **Products**: Stores product details
* **Orders**: Tracks customer orders
* **OrderDetails**: Contains detailed product-level information for each order

### Sample Data:

Sample records are inserted into each table to demonstrate how the data is related and how queries can be run.

---

##  Key SQL Features Used:

* `CREATE TABLE`, `INSERT INTO`
* `JOIN` operations (INNER, LEFT, RIGHT)
* `GROUP BY` with aggregate functions like `SUM`
* `ORDER BY`, `WHERE`, `HAVING`
* Views (`CREATE VIEW`)
* Indexing (`CREATE INDEX`)

---

## Sample Queries:

* List of customers from a specific city
* Total quantity sold per product
* Customer and product details per order
* All customers and their orders (if any)
* Products that have been ordered more than once
* Summary view of orders including total amount spent

---

## View: `OrderSummary`

A view is created to show each order's customer name and the total amount spent on that order.

```sql
CREATE VIEW OrderSummary AS
SELECT o.order_id, c.name AS customer_name, SUM(p.price * od.quantity) AS total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY o.order_id, c.name;
```

---

## Learning Goals:

✅ Understand basic relational database design
✅ Practice SQL queries and joins
✅ Work with views and indexes for performance and analysis

---

## Tools Used:

* SQL (MySQL / SQLite / PostgreSQL compatible)
* Local SQL environment or tools like **MySQL Workbench**, **DBeaver**, or **DB Fiddle**

---

## How to Use

1. Copy the SQL script into your SQL environment
2. Run the script step-by-step to create the database, insert data, and run queries
3. Explore and modify the queries to suit your learning


