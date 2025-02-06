create Database pract
-- Customers Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

select * from Customer
INSERT INTO Customer (customer_id, name, email, city) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'New York'),
(2, 'Bob Smith', 'bob@example.com', 'Los Angeles'),
(3, 'Charlie Brown', 'charlie@example.com', 'Chicago');

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity INT
);

INSERT INTO Products (product_id, name, price, stock_quantity) VALUES
(101, 'Laptop', 999.99, 10),
(102, 'Smartphone', 499.99, 20),
(103, 'Headphones', 79.99, 50);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(1001, 1, '2024-02-01', 1079.98),
(1002, 2, '2024-02-02', 499.99),
(1003, 3, '2024-02-03', 79.99);

-- OrderDetails Table (Many-to-Many Relationship)
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price) VALUES
(1, 1001, 101, 1, 999.99),
(2, 1001, 103, 1, 79.99),
(3, 1002, 102, 1, 499.99),
(4, 1003, 103, 1, 79.99);

- Retrieve all customers who live in "New York."
select * from Customer where city = 'New York'
select * from Customer

-Find all orders placed on or after "2024-02-02."
select * from Orders where order_date >= '20240202'

-Get the total number of orders placed by each customer.
select count(orders.order_id) as orders , Customer.name from Customer 
INNER JOIN Orders 
on Customer.customer_id = Orders.customer_id 
group by Customer.name

-List the product names and their prices for all products that cost more than $100.
select Products.name , Products.price from Products where price > 100

-Retrieve all order details for a specific order ID (e.g., 1001), including product names and quantities.
select * from OrderDetails
INNER JOIN Products
On OrderDetails.product_id = Products.product_id
where OrderDetails.order_id = 1001

Find the total revenue generated from all orders.
select sum(Products.price* OrderDetails.quantity) from Products
INNER JOIN OrderDetails On OrderDetails.product_id = Products.product_id

Display the customer name and the total amount they have spent on orders.
select Customer.name , Orders.total_amount from Customer 
INNER JOIN Orders 
on Customer.customer_id = Orders.customer_id 
