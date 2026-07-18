-- Q1 Total Customers
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

-- Q2 Total Orders
SELECT COUNT(*) AS TotalOrders
FROM Orders;

-- Q3 Total Products
SELECT COUNT(*) AS TotalProducts
FROM Products;

-- Q4 Total Employees
SELECT COUNT(*) AS TotalEmployees
FROM Employees;

-- Q5 Total Suppliers
SELECT COUNT(*) AS TotalSuppliers
FROM Suppliers;

-- Q6 First Order Date
SELECT TOP 1 OrderID, CustomerID, OrderDate
FROM Orders
ORDER BY OrderDate ASC;

-- Q7 Latest Order Date
SELECT TOP 1 OrderID, CustomerID, OrderDate
FROM Orders
ORDER BY OrderDate DESC;

-- Q8 Countries Served
SELECT DISTINCT Country
FROM Customers;

-- Q9 Total Categories
SELECT COUNT(*) AS TotalCategories
FROM Categories;

-- Q10 Top 5 Most Expensive Products
SELECT TOP 5 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC;
