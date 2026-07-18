-- Q11 Total Revenue

SELECT
    SUM(Quantity * UnitPrice * (1 - Discount)) AS TotalRevenue
FROM [Order Details];


-- Q12 Top 10 Customers by Revenue

SELECT TOP 10
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue,
    c.CustomerID
FROM [Order Details] od
INNER JOIN Orders o
    ON od.OrderID = o.OrderID
INNER JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY Revenue DESC;


-- Q13 Top 10 Products by Revenue

SELECT TOP 10
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue,
    p.ProductName
FROM Products p
INNER JOIN [Order Details] od
    ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY Revenue DESC;


-- Q14 Revenue by Category

SELECT
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Revenue,
    c.CategoryName
FROM Categories c
INNER JOIN Products p
    ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] od
    ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY Revenue DESC;


-- Q15 Monthly Revenue Trend

SELECT
    MONTH(o.OrderDate) AS OrderMonth,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Revenue
FROM Orders o
JOIN [Order Details] od
    ON o.OrderID = od.OrderID
GROUP BY MONTH(o.OrderDate)
ORDER BY OrderMonth;
