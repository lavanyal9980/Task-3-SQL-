
-- Task 1: Top 10 Selling Products by Quantity
SELECT Description, SUM(Quantity) AS TotalQuantity
FROM online_retail
WHERE Quantity > 0
GROUP BY Description
ORDER BY TotalQuantity DESC
LIMIT 10;

-- Task 2: Total Revenue per Country (Top 10)
SELECT Country, SUM(Quantity * UnitPrice) AS TotalRevenue
FROM online_retail
WHERE Quantity > 0
GROUP BY Country
ORDER BY TotalRevenue DESC
LIMIT 10;

-- Task 3: Monthly Sales Trend
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, SUM(Quantity * UnitPrice) AS MonthlyRevenue
FROM online_retail
WHERE Quantity > 0
GROUP BY Month
ORDER BY Month;

-- Task 4: Top 5 Customers by Revenue
SELECT CustomerID, SUM(Quantity * UnitPrice) AS Revenue
FROM online_retail
WHERE Quantity > 0 AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 5;

-- Task 5: Most Frequently Purchased Product per Country
SELECT Country, Description, SUM(Quantity) AS TotalQuantity
FROM online_retail
WHERE Quantity > 0
GROUP BY Country, Description
HAVING TotalQuantity = (
    SELECT MAX(SQ.TotalQuantity)
    FROM (
        SELECT Country AS C, Description AS D, SUM(Quantity) AS TotalQuantity
        FROM online_retail
        WHERE Quantity > 0
        GROUP BY Country, Description
    ) AS SQ
    WHERE SQ.C = online_retail.Country
)
ORDER BY Country;
