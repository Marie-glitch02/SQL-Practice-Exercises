# SQL Practice Exercises

This repository contains SQL practice exercises to help improve SQL querying skills. The exercises involve working with a simple e-commerce database with four tables: `Customers`, `Products`, `Orders`, and `OrderDetails`.

## Database Schema

The schema consists of the following tables:

1. **Customers** – Stores customer details.
2. **Products** – Contains product information.
3. **Orders** – Stores customer orders.
4. **OrderDetails** – Stores details of each order, linking orders with products.

## Table Definitions

```sql
-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity INT
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
```
## Sample Data
```
INSERT INTO Customers (customer_id, name, email, city) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'New York'),
(2, 'Bob Smith', 'bob@example.com', 'Los Angeles'),
(3, 'Charlie Brown', 'charlie@example.com', 'Chicago');

INSERT INTO Products (product_id, name, price, stock_quantity) VALUES
(101, 'Laptop', 999.99, 10),
(102, 'Smartphone', 499.99, 20),
(103, 'Headphones', 79.99, 50);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(1001, 1, '2024-02-01', 1079.98),
(1002, 2, '2024-02-02', 499.99),
(1003, 3, '2024-02-03', 79.99);

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price) VALUES
(1, 1001, 101, 1, 999.99),
(2, 1001, 103, 1, 79.99),
(3, 1002, 102, 1, 499.99),
(4, 1003, 103, 1, 79.99);
```
## Practice Queries
### 1. Retrieve all customers who live in "New York."
```
SELECT * FROM Customers WHERE city = 'New York';
```
### 2. Find all orders placed on or after "2024-02-02."
```
SELECT * FROM Orders WHERE order_date >= '2024-02-02';
```
### 3. Get the total number of orders placed by each customer.
```
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM Customers c  
LEFT JOIN Orders o ON c.customer_id = o.customer_id  
GROUP BY c.name;
```
### 4. List the product names and their prices for all products that cost more than $100.
```
SELECT name, price FROM Products WHERE price > 100;
```
### 5. Retrieve all order details for a specific order ID (e.g., 1001), including product names and quantities.
```
SELECT od.order_id, p.name AS product_name, od.quantity, od.price
FROM OrderDetails od
INNER JOIN Products p ON od.product_id = p.product_id
WHERE od.order_id = 1001;
```
### 6. Find the total revenue generated from all orders.
```
SELECT SUM(od.price * od.quantity) AS total_revenue FROM OrderDetails od;
```
### 7. Display the customer name and the total amount they have spent on orders.
```
SELECT c.name, SUM(o.total_amount) AS total_spent  
FROM Customers c  
JOIN Orders o ON c.customer_id = o.customer_id  
GROUP BY c.name;
```
### 8. List products that have not been ordered yet.
```
SELECT p.name, p.price
FROM Products p  
LEFT JOIN OrderDetails od ON p.product_id = od.product_id  
WHERE od.product_id IS NULL;
```
### 9. Update the stock quantity of "Laptop" after a purchase of 2 units.
```
UPDATE Products SET stock_quantity = stock_quantity - 2 WHERE product_id = 101;
```
### 10. Delete an order (e.g., Order ID 1003) and ensure related records in OrderDetails are also removed.
```
DELETE FROM OrderDetails WHERE order_id = 1003;  
DELETE FROM Orders WHERE order_id = 1003;
```
