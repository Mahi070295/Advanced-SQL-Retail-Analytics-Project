2. month over month growth

WITH monthly_sales AS(
SELECT 
     date_trunc( 'month',order_date) AS MONTH,
     sum(quantity*selling_price*(1-discount)) AS revenue 
 FROM sales
 GROUP BY MONTH
)

SELECT 
     to_char(MONTH, 'month') AS month_name,
     revenue,
     revenue-lag(revenue)OVER(ORDER BY MONTH) AS revenue_change,
     round((revenue-lag(revenue)OVER(ORDER BY MONTH))/lag(revenue)OVER(ORDER BY MONTH)*100,2) AS growth_percentage
     FROM monthly_sales;
  
  
