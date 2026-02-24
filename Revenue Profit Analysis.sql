1. Monthly revenue using CTE

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS MONTH,
        SUM(quantity * selling_price * (1 - discount)) AS revenue
    FROM sales
    GROUP BY MONTH
)

SELECT 
    TO_CHAR(MONTH, 'Month') AS month_name,
    revenue
FROM monthly_sales
ORDER BY MONTH;
