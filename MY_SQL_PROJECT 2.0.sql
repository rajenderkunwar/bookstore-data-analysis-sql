create database ai;
use ai;

show tables;

select * from books;
select * from customers;
select * from orders;

--  BASIC QUERIES
-- 1) Retrieve all books in the "Fiction" genre
SELECT * 
FROM books
WHERE Genre = 'Fiction';

-- 2) Find books published after 1950
SELECT * 
FROM books
WHERE Published_Year > 1950
ORDER BY Published_Year;

-- 3) List all customers from Canada
SELECT * 
FROM customers
WHERE Country = 'Canada';

-- 4) Show orders placed in November 2023
SELECT * 
FROM orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve total stock of books available
SELECT SUM(Stock) AS Available_Stock 
FROM books;

-- 6) Find the most expensive book
SELECT * 
FROM books
ORDER BY Price DESC
LIMIT 1;

-- 7) Show customers who ordered more than 1 quantity
SELECT * 
FROM orders
WHERE Quantity > 1;

-- 8) Retrieve orders where total amount exceeds $20
SELECT * 
FROM orders
WHERE Total_Amount > 20;

-- 9) List all available genres
SELECT DISTINCT Genre 
FROM books;

-- 10) Find the book with the lowest stock
SELECT * 
FROM books
ORDER BY Stock ASC
LIMIT 1;

-- 11) Calculate total revenue
SELECT SUM(Total_Amount) AS Revenue 
FROM orders;


 -- ADVANCED QUERIES 

-- 1) Total number of books sold per genre
SELECT 
    b.Genre,
    SUM(o.Quantity) AS Total_Books_Sold
FROM books b
JOIN orders o 
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre;

-- 2) Average price of Fantasy books
SELECT 
    AVG(Price) AS Avg_Price
FROM books
WHERE Genre = 'Fantasy';

-- 3) Customers who placed at least 2 orders
SELECT 
    Customer_ID,
    COUNT(Order_ID) AS Total_Orders
FROM orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID) >= 2;

-- 4) Most frequently ordered book
SELECT 
    b.Title,
    COUNT(o.Book_ID) AS Order_Count
FROM books b
JOIN orders o 
    ON b.Book_ID = o.Book_ID
GROUP BY b.Title
ORDER BY Order_Count DESC
LIMIT 1;

-- 5) Top 3 most expensive Fantasy books
SELECT 
    Title,
    Price
FROM books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 6) Total quantity sold by each author
SELECT 
    b.Author,
    SUM(o.Quantity) AS Total_Quantity_Sold
FROM books b
JOIN orders o 
    ON b.Book_ID = o.Book_ID
GROUP BY b.Author;

-- 7) Cities of customers who spent more than $30
SELECT 
    c.City,
    SUM(o.Total_Amount) AS Total_Spent
FROM customers c
JOIN orders o 
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.City
HAVING SUM(o.Total_Amount) > 30;

-- 8) Customer who spent the most
SELECT 
    c.Name,
    SUM(o.Total_Amount) AS Total_Spent
FROM customers c
JOIN orders o 
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Name
ORDER BY Total_Spent DESC
LIMIT 1;

-- 9) Remaining stock after fulfilling orders
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Stock
FROM books b
LEFT JOIN orders o 
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;


--  10) Rank customers by spending (Window Function)
SELECT 
    c.Name,
    SUM(o.Total_Amount) AS Total_Spent,
    RANK() OVER (ORDER BY SUM(o.Total_Amount) DESC) AS Rank_Position
FROM customers c
JOIN orders o 
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Name;

--  11) Monthly revenue trend
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    SUM(Total_Amount) AS Revenue
FROM orders
GROUP BY Month
ORDER BY Month;

-- IMPORTANT INSIGHTS
-- 1 Revenue Concentration
-- A small group of customers contributes a disproportionately high share of total revenue, indicating high-value customer segments.

-- 2 Genre Performance
-- Certain genres (e.g., Fiction/Fantasy) dominate sales, showing clear customer preference trends.

-- 3 Inventory Risk
-- Some books are consistently low in stock, suggesting potential stock-out risks and demand-supply imbalance.

-- 4  Top Customer Behavior
-- The highest-spending customer significantly exceeds average spending, indicating loyalty or bulk purchasing patterns.

-- 5  Sales Distribution by Author
-- A few authors contribute most of the total book sales, highlighting author-driven demand concentration.

-- 6  Order Patterns
-- Majority of orders consist of low quantities (1–2 books), indicating retail-style purchasing rather than bulk buying.

