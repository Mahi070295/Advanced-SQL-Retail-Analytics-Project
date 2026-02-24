 Top 3 Products per month

WITH monthly_sales AS (
SELECT date_trunc('month',s.order_date) AS MONTH,
p.product_id,
p.brand,
Sum(s.quantity*s.selling_price*(1-s.discount)) AS revenue 
FROM sales s LEFT JOIN products p 
ON s.product_id=p.product_id
GROUP BY p.product_id,date_trunc('month',s.order_date)
)

SELECT * FROM
(SELECT to_char(MONTH,'month')AS month_name,
product_id,
revenue,
brand,
row_number()OVER(PARTITION BY MONTH ORDER BY revenue DESC) AS rank
FROM monthly_sales) ranked
 WHERE rank<=3;
