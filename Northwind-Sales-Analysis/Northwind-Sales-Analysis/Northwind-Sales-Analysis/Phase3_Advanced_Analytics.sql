-- Q16 Top 5 Customers by Number of Orders

SELECT TOP 5
    c.CustomerID,
    c.CompanyName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CompanyName
ORDER BY TotalOrders DESC;


-- Q17 Average Order Value

SELECT
    SUM(UnitPrice * Quantity * (1 - Discount))
    / COUNT(DISTINCT OrderID) AS AverageOrderValue
FROM [Order Details];


-- Q18 Top 5 Categories by Revenue

SELECT TOP 5
    c.CategoryName,
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue
FROM Categories c
INNER JOIN Products p
    ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] od
    ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY Revenue DESC;


-- Q19 Employee Who Generated Highest Revenue

SELECT TOP 1
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    e.Title,
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue
FROM Employees e
INNER JOIN Orders o
    ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] od
    ON o.OrderID = od.OrderID
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Title
ORDER BY Revenue DESC;


-- Q20 Revenue by Country

SELECT
    c.Country,
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od
    ON o.OrderID = od.OrderID
GROUP BY c.Country
ORDER BY Revenue DESC;


-- Q21 Top 5 Customers Contributing Highest % of Revenue

WITH CustomerRevenue AS
(
    SELECT
        c.CustomerID,
        c.CompanyName,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Revenue
    FROM Customers c
    INNER JOIN Orders o
        ON c.CustomerID = o.CustomerID
    INNER JOIN [Order Details] od
        ON o.OrderID = od.OrderID
    GROUP BY
        c.CustomerID,
        c.CompanyName
)

SELECT TOP 5
    CustomerID,
    CompanyName,
    Revenue,
    ROUND(
        Revenue * 100.0 /
        SUM(Revenue) OVER (),
        2
    ) AS RevenuePercentage
FROM CustomerRevenue
ORDER BY Revenue DESC;


-- Q22 Product Category with Highest Average Selling Price

SELECT
    c.CategoryName,
    AVG(od.UnitPrice) AS AverageSellingPrice
FROM Categories c
INNER JOIN Products p
    ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] od
    ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY AverageSellingPrice DESC;


-- Q23 Running Revenue by Month

WITH MonthlyRevenue AS
(
    SELECT
        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,
        SUM(
            od.Quantity * od.UnitPrice * (1 - od.Discount)
        ) AS Revenue
    FROM Orders o
    INNER JOIN [Order Details] od
        ON o.OrderID = od.OrderID
    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
)

SELECT
    OrderYear,
    OrderMonth,
    Revenue,
    SUM(Revenue) OVER(
        ORDER BY OrderYear, OrderMonth
    ) AS RunningRevenue
FROM MonthlyRevenue
ORDER BY OrderYear, OrderMonth;


-- Q24 Rank Products by Revenue Within Each Category

SELECT
    c.CategoryName,
    p.ProductName,
    SUM(
        od.Quantity * od.UnitPrice * (1 - od.Discount)
    ) AS Revenue,
    RANK() OVER
    (
        PARTITION BY c.CategoryName
        ORDER BY
        SUM(
            od.Quantity * od.UnitPrice * (1 - od.Discount)
        ) DESC
    ) AS ProductRank
FROM Categories c
INNER JOIN Products p
    ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] od
    ON p.ProductID = od.ProductID
GROUP BY
    c.CategoryName,
    p.ProductName
ORDER BY
    c.CategoryName,
    ProductRank;


-- Q25 Customers Who Placed Orders in Every Year Available

SELECT
    c.CustomerID,
    c.CompanyName
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CompanyName
HAVING COUNT(DISTINCT YEAR(o.OrderDate))
=
(
    SELECT COUNT(DISTINCT YEAR(OrderDate))
    FROM Orders
);
