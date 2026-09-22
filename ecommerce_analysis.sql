-- E-Commerce Sales Analytics
-- MySQL Database & Table


CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;

CREATE TABLE ecommerce_sales (
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Platform VARCHAR(50),
    Customer_ID VARCHAR(50),
    Product VARCHAR(100),
    Price DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Revenue DECIMAL(12,2),
    Country VARCHAR(100)
);

SHOW TABLES;

SELECT COUNT(*) AS total_rows
FROM ecommerce_sales;

SELECT 
   SUM(Revenue) AS Total_Revenue
FROM ecommerce_sales;

SELECT 
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM ecommerce_sales;

SELECT 
    SUM(Quantity) AS Total_Quantity
FROM ecommerce_sales;

SELECT
    Platform,
    SUM(Revenue) AS Total_Revenue
FROM ecommerce_sales
GROUP BY Platform
ORDER BY Total_Revenue DESC;


SELECT
    Product,
    SUM(Revenue) AS Total_Revenue
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Revenue DESC;


SELECT
    Product,
    SUM(Quantity) AS Total_Quantity_Sold
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Quantity_Sold DESC;

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    SUM(Revenue) AS Total_Revenue
FROM ecommerce_sales
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Month;

SELECT
    Country,
    SUM(Revenue) AS Total_Revenue
FROM ecommerce_sales
GROUP BY Country
ORDER BY Total_Revenue DESC
LIMIT 10;

SELECT
    Platform,
    ROUND(AVG(Revenue), 2) AS Average_Order_Value
FROM ecommerce_sales
GROUP BY Platform
ORDER BY Average_Order_Value DESC;


SELECT
    Discount,
    ROUND(AVG(Revenue), 2) AS Average_Revenue
FROM ecommerce_sales
GROUP BY Discount
ORDER BY Discount;

SELECT
    Customer_ID,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM ecommerce_sales
GROUP BY Customer_ID
ORDER BY Total_Revenue DESC
LIMIT 10;


SELECT
    Product,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    RANK() OVER (
        ORDER BY SUM(Revenue) DESC
    ) AS Revenue_Rank
FROM ecommerce_sales
GROUP BY Product
ORDER BY Revenue_Rank;


WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        SUM(Revenue) AS Monthly_Revenue
    FROM ecommerce_sales
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Month,
    ROUND(Monthly_Revenue, 2) AS Monthly_Revenue,
    ROUND(
        SUM(Monthly_Revenue) OVER (
            ORDER BY Month
        ),
        2
    ) AS Cumulative_Revenue
FROM monthly_sales
ORDER BY Month;


SELECT
    Order_ID,
    Order_Date,
    Platform,
    Customer_ID,
    Product,
    Quantity,
    Discount,
    ROUND(Revenue, 2) AS Revenue,
    Country
FROM ecommerce_sales
ORDER BY Revenue DESC
LIMIT 10;

SELECT
    Platform,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Average_Order_Value
FROM ecommerce_sales
GROUP BY Platform
ORDER BY Total_Revenue DESC;


SELECT
    Product,
    SUM(Quantity) AS Total_Quantity_Sold,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Average_Order_Value
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Revenue DESC;


SELECT
    Order_ID,
    Product,
    Revenue,
    CASE
        WHEN Revenue < 1000 THEN 'Low Revenue'
        WHEN Revenue >= 1000 AND Revenue < 3000 THEN 'Medium Revenue'
        ELSE 'High Revenue'
    END AS Revenue_Category
FROM ecommerce_sales
ORDER BY Revenue DESC;

SELECT
    Product,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM ecommerce_sales
GROUP BY Product
HAVING SUM(Revenue) > 1500000
ORDER BY Total_Revenue DESC;


SELECT
    Order_ID,
    Product,
    Platform,
    Revenue
FROM ecommerce_sales
WHERE Revenue > (
    SELECT AVG(Revenue)
    FROM ecommerce_sales
)
ORDER BY Revenue DESC;

SELECT
    Product,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM ecommerce_sales
GROUP BY Product
HAVING SUM(Revenue) > (
    SELECT AVG(Product_Revenue)
    FROM (
        SELECT SUM(Revenue) AS Product_Revenue
        FROM ecommerce_sales
        GROUP BY Product
    ) AS product_summary
)
ORDER BY Total_Revenue DESC;

WITH product_sales AS (
    SELECT
        Product,
        ROUND(SUM(Revenue), 2) AS Total_Revenue
    FROM ecommerce_sales
    GROUP BY Product
)
SELECT
    Product,
    Total_Revenue
FROM product_sales
ORDER BY Total_Revenue DESC
LIMIT 5;

WITH product_sales AS (
    SELECT
        Product,
        ROUND(SUM(Revenue), 2) AS Total_Revenue
    FROM ecommerce_sales
    GROUP BY Product
)
SELECT
    Product,
    Total_Revenue,
    RANK() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank
FROM product_sales
ORDER BY Revenue_Rank;


SELECT
    Order_ID,
    Product,
    Platform,
    ROUND(Revenue, 2) AS Revenue,
    ROW_NUMBER() OVER (
        ORDER BY Revenue DESC
    ) AS Revenue_Row_Number
FROM ecommerce_sales
ORDER BY Revenue_Row_Number;


WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        ROUND(SUM(Revenue), 2) AS Monthly_Revenue
    FROM ecommerce_sales
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)
SELECT
    Month,
    Monthly_Revenue,
    LAG(Monthly_Revenue) OVER (
        ORDER BY Month
    ) AS Previous_Month_Revenue
FROM monthly_sales
ORDER BY Month;


WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        ROUND(SUM(Revenue), 2) AS Monthly_Revenue
    FROM ecommerce_sales
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
monthly_comparison AS (
    SELECT
        Month,
        Monthly_Revenue,
        LAG(Monthly_Revenue) OVER (
            ORDER BY Month
        ) AS Previous_Month_Revenue
    FROM monthly_sales
)
SELECT
    Month,
    Monthly_Revenue,
    Previous_Month_Revenue,
    ROUND(
        ((Monthly_Revenue - Previous_Month_Revenue)
        / Previous_Month_Revenue) * 100,
        2
    ) AS MoM_Growth_Percentage
FROM monthly_comparison
ORDER BY Month;


WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        ROUND(SUM(Revenue), 2) AS Monthly_Revenue
    FROM ecommerce_sales
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)
SELECT
    Month,
    Monthly_Revenue,
    ROUND(
        SUM(Monthly_Revenue) OVER (
            ORDER BY Month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS Cumulative_Revenue
FROM monthly_sales
ORDER BY Month;

WITH product_platform_sales AS (
    SELECT
        Platform,
        Product,
        ROUND(SUM(Revenue), 2) AS Total_Revenue
    FROM ecommerce_sales
    GROUP BY Platform, Product
),
ranked_products AS (
    SELECT
        Platform,
        Product,
        Total_Revenue,
        ROW_NUMBER() OVER (
            PARTITION BY Platform
            ORDER BY Total_Revenue DESC
        ) AS Product_Rank
    FROM product_platform_sales
)
SELECT
    Platform,
    Product,
    Total_Revenue
FROM ranked_products
WHERE Product_Rank = 1
ORDER BY Total_Revenue DESC;


WITH customer_sales AS (
    SELECT
        Customer_ID,
        ROUND(SUM(Revenue), 2) AS Total_Revenue
    FROM ecommerce_sales
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    Total_Revenue,
    CASE
        WHEN Total_Revenue < 1500 THEN 'Low Value'
        WHEN Total_Revenue < 3000 THEN 'Medium Value'
        ELSE 'High Value'
    END AS Customer_Segment
FROM customer_sales
ORDER BY Total_Revenue DESC;


WITH platform_sales AS (
    SELECT
        Platform,
        COUNT(DISTINCT Order_ID) AS Total_Orders,
        ROUND(SUM(Revenue), 2) AS Total_Revenue,
        ROUND(AVG(Revenue), 2) AS Average_Order_Value
    FROM ecommerce_sales
    GROUP BY Platform
)
SELECT
    Platform,
    Total_Orders,
    Total_Revenue,
    Average_Order_Value,
    RANK() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank,
    CASE
        WHEN Total_Revenue >= 3700000 THEN 'High Performance'
        WHEN Total_Revenue >= 3650000 THEN 'Medium Performance'
        ELSE 'Standard Performance'
    END AS Performance_Category
FROM platform_sales
ORDER BY Revenue_Rank;