Churn Analysis

WITH latest_date AS (
    SELECT MAX(order_date) AS max_date
    FROM sales
),

last_purchase AS (
    SELECT 
        customer_id,
        MAX(order_date) AS last_purchase_date
    FROM sales
    GROUP BY customer_id
),

customer_status AS (
    SELECT 
        lp.customer_id,
        lp.last_purchase_date,
        ld.max_date,
        (ld.max_date - lp.last_purchase_date) AS days_inactive,
        CASE 
            WHEN (ld.max_date - lp.last_purchase_date) > 60 
            THEN 1 
            ELSE 0 
        END AS churn_flag
    FROM last_purchase lp
    CROSS JOIN latest_date ld
)

SELECT 
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(
        SUM(churn_flag)::DECIMAL / COUNT(*) * 100, 
        2
    ) AS churn_rate_percentage
FROM customer_status;