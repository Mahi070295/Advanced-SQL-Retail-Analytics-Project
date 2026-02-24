4- CLV Analysis 

WITH customer_revenue AS
(SELECT 
     customer_id,
     sum(quantity*selling_price*(1-discount)) AS lifetime_value
     FROM sales
     GROUP BY customer_id 
)

SELECT 
    customer_id,
    lifetime_value,
    rank() OVER(ORDER BY lifetime_value DESC ) AS customer_rank FROM customer_revenue;
