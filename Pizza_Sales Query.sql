--Preview of the imported data
SELECT *
FROM pizza_sales

--Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

--Average Order Value
SELECT SUM(total_price)/ COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales

--Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales

--Total Orders
SELECT COUNT (DISTINCT order_id ) AS Total_Orders
FROM pizza_sales

--Average Pizza Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/ CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizza_Per_Order
FROM pizza_sales

--CHART REQUIREMENTS
--DAILY TRENDS
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC


-- Hourly Trend
SELECT DATEPART(HOUR, order_time) AS Order_Hours, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--Percentage of Sales by Pizza Category
SELECT pizza_category,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, 
CAST(CAST(SUM(total_price) * 100 AS DECIMAL(10,2)) / CAST((SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS PTS
FROM pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_category

--Percentage of Sales by Pizza Size
SELECT * FROM pizza_sales

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2))AS Total_Sales,CAST(SUM(total_price) * 100/(SELECT SUM(total_price) FROM pizza_sales)AS DECIMAL(10,2)) AS PPS
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PPS DESC

--Total Pizzas Sold per Pizza Category
SELECT pizza_category, SUM(quantity) AS Total_Pizzas
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizzas DESC

--TOP 5 BEST SELLERS BY TOTAL PIZZAS SOLD
SELECT * FROM pizza_sales

SELECT TOP (5) pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC

--BOTTOM 5 WORST SELLERS BY TOTAL PIZZAS SOLD
SELECT * FROM pizza_sales

SELECT TOP(5) pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold



